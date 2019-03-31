module Figures.Fig13 exposing (..)


import Html exposing (Html)
import Collage exposing (defaultLineStyle)
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
        lineColor r =
            spin (degrees r) Color.darkBlue
                |> Collage.uniform
        fillColor r =
            Color.darkBlue
            |> lighten  0.3
            |> saturate 0.2
            |> spin (degrees r)
            |> Collage.uniform
        triangle r1 r2 =
            Collage.triangle 40
                |> Collage.styled
                    ( fillColor r2
                    , { defaultLineStyle | thickness = 6.0, fill = lineColor r1 }
                    )
    in
        List.map2 triangle [ -30.0, 30.0 ] [ -20.0, 40.0 ]
            |> Layout.horizontal
            |> Layout.align Layout.base
            |> List.singleton
            |> List.append [ triangle 0.0 10.0 ]
            |> Layout.vertical
            |> Render.svg

