module Figures.Fig27 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout
import Color


spin : Float -> Color.Color -> Color.Color
spin angle color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + angle) saturation lightness alpha


rectangle : Color.Color -> Collage.Collage msg
rectangle color =
    Collage.filled (Collage.uniform color) (Collage.rectangle 60 60)


grandientBoxes : Int -> Color.Color -> Collage.Collage msg
grandientBoxes n color =
    case n of
        0 -> Layout.empty
        _ -> color
                |> spin (degrees 15)
                |> grandientBoxes (n - 1)
                |> List.singleton
                |> (::) (rectangle color)
                |> Layout.horizontal


main : Html msg
main =
    Render.svg (grandientBoxes 5 Color.blue)

