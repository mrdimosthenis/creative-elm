module Figures.Fig11 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout
import Color


lighten : Color.Color -> Float -> Color.Color
lighten color diff =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue saturation (lightness + diff) alpha


saturate : Color.Color -> Float -> Color.Color
saturate color diff =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue (saturation + diff) lightness alpha


main : Html msg
main =
    let
        circleLightedBy x =
            (lighten Color.red x
                |> Collage.uniform
                |> Collage.filled)
                <| Collage.circle 20
        circles =
            List.map circleLightedBy [ -0.2, 0.0, 0.2 ]
        rectangleSaturatedBy x =
            (saturate Color.red x
                |> Collage.uniform
                |> Collage.filled)
                <| Collage.rectangle 40 40
        rectangles =
            List.map rectangleSaturatedBy [ -0.6, -0.3 , 0.0 ]
    in
    [ circles, rectangles ]
        |> List.map Layout.horizontal
        |> Layout.vertical
        |> Render.svg

