module Figures.Fig11 exposing (lighten, main, saturate)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


lighten : Float -> Color.Color -> Color.Color
lighten diff color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue saturation (lightness + diff) alpha


saturate : Float -> Color.Color -> Color.Color
saturate diff color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue (saturation + diff) lightness alpha


main : Html msg
main =
    let
        circleLightedBy x =
            (lighten x Color.red
                |> Collage.uniform
                |> Collage.filled
            )
            <|
                Collage.circle 20

        circles =
            List.map circleLightedBy [ -0.2, 0.0, 0.2 ]

        rectangleSaturatedBy x =
            (saturate x Color.red
                |> Collage.uniform
                |> Collage.filled
            )
            <|
                Collage.rectangle 40 40

        rectangles =
            List.map rectangleSaturatedBy [ -0.6, -0.3, 0.0 ]
    in
    [ circles, rectangles ]
        |> List.map Layout.horizontal
        |> Layout.vertical
        |> Render.svg
