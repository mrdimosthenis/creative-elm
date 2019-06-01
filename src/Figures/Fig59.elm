module Figures.Fig59 exposing (..)

import Browser
import Collage exposing (Collage, defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color exposing (Color)
import Html exposing (Html)
import Random
import Random.Float as RandFl


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


init : () -> (Model, Cmd Msg)
init _ =
    let
        command =
            Color.blue
            |> randomGradientBoxes 9
            |> Random.generate GradientBoxes
    in
    (Layout.empty, command)


-- UPDATE


type Msg
  = GradientBoxes (Collage Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg _ =
  case msg of
    GradientBoxes gradientBoxes ->
      ( gradientBoxes, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    Render.svg model


-- Actual Implementation


spin : Float -> Color.Color -> Color.Color
spin angle color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + angle) saturation lightness alpha


nextColor : Color.Color -> Random.Generator Color.Color
nextColor color =
    Random.map (\s -> spin (degrees s) color) (RandFl.normal 15.0 10.0)


coloredRectangle : Color.Color -> Collage.Collage msg
coloredRectangle color =
    Collage.styled
            ( Collage.uniform color
            , { defaultLineStyle
              | fill = Collage.uniform (spin (degrees 30) color)
              , thickness = 2.5
              }
            )
            (Collage.rectangle 40 40)


randomGradientBoxes : Int -> Color.Color -> Random.Generator (Collage.Collage msg)
randomGradientBoxes n color =
    case n of
        0 -> Random.constant Layout.empty
        _ -> let
                box =
                    coloredRectangle color
                boxes =
                    color
                    |> nextColor
                    |> Random.andThen (randomGradientBoxes (n - 1))
             in
             boxes
             |> Random.map (\b -> Layout.horizontal (box :: [b]))

