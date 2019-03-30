module Figures.Fig10 exposing (..)


import Html exposing (Html)
import Collage exposing (defaultLineStyle)
import Collage.Render as Render
import Collage.Layout as Layout
import Color


spin : Color.Color -> Float -> Color.Color
spin color angle =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + angle) saturation lightness alpha


main : Html msg
main =
    let
        redRotatedBy r =
            degrees r
                |> spin Color.red
                |> Collage.uniform
    in
    [ 0, 15, 30 ]
        |> List.map (\r -> Collage.circle 100
                             |> Collage.styled
                                 ( redRotatedBy r
                                 , { defaultLineStyle | thickness = 5.0 }
                                 )
                    )
        |> Layout.horizontal
        |> Render.svg

