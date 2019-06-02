module Figures.Fig56 exposing (Model, Msg(..), init, main, randomCircle, randomColor, randomConcentricCircles, randomHue, randomPastel, subscriptions, update, view)

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
    ( Layout.empty, Random.generate ConcentricCircles (randomConcentricCircles 10 10.0) )



-- UPDATE


type Msg
    = ConcentricCircles (Collage Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        ConcentricCircles concentricCircles ->
            ( concentricCircles, Cmd.none )



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


randomColor : Float -> Float -> Random.Generator Color.Color
randomColor saturation lightness =
    Random.map (\hue -> Color.hsla hue saturation lightness 1.0) randomHue


randomPastel : Random.Generator Color.Color
randomPastel =
    randomColor 0.7 0.7


randomCircle : Float -> Random.Generator Color.Color -> Random.Generator (Collage.Collage msg)
randomCircle radius randColor =
    let
        f =
            \color ->
                radius
                    |> Collage.circle
                    |> Collage.filled (Collage.uniform color)
    in
    Random.map f randColor


randomConcentricCircles : Int -> Float -> Random.Generator (Collage.Collage msg)
randomConcentricCircles n radius =
    case n of
        0 ->
            Random.constant Layout.empty

        _ ->
            randomCircle radius randomPastel
                |> Random.andThen
                    (\circle ->
                        randomConcentricCircles (n - 1) (radius + 5)
                            |> Random.map (\circles -> Layout.stack [ circle, circles ])
                    )
