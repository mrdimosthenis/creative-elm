module Figures.Fig57 exposing (Model, Msg(..), coloredRectangle, init, main, randomColor, randomColorBoxes, randomHue, subscriptions, update, view)

import Browser
import Collage exposing (Collage)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)
import Random



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    Collage Msg


init : () -> ( Model, Cmd Msg )
init _ =
    ( Layout.empty, Random.generate ColorBoxes (randomColorBoxes 4) )



-- UPDATE


type Msg
    = ColorBoxes (Collage Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        ColorBoxes colorBoxes ->
            ( colorBoxes, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    Render.svg model



-- Actual Implementation


randomHue : Random.Generator Float
randomHue =
    Random.float 0 1


randomColor : Random.Generator Color.Color
randomColor =
    Random.map (\hue -> Color.hsla hue 0.7 0.7 1.0) randomHue


coloredRectangle : Color.Color -> Collage.Collage msg
coloredRectangle color =
    Collage.filled (Collage.uniform color) (Collage.rectangle 40 40)


randomColorBoxes : Int -> Random.Generator (Collage.Collage msg)
randomColorBoxes n =
    let
        box =
            Random.map coloredRectangle randomColor
    in
    case n of
        0 ->
            box

        _ ->
            box
                |> Random.andThen
                    (\b ->
                        randomColorBoxes (n - 1)
                            |> Random.map (\bs -> Layout.horizontal [ b, bs ])
                    )
