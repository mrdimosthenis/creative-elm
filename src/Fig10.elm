module Figures.Fig10 exposing (..)


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


main : Html msg
main =
    let
        redRotatedBy r =
            spin (degrees r) Color.red
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

