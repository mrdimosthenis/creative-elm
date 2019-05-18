module Figures.Fig40 exposing (..)


import Html exposing (Html)
import Collage exposing (defaultLineStyle)
import Collage.Render as Render
import Collage.Layout as Layout
import Color


triangle : Collage.Shape
triangle =
    Collage.ngon 3 50


square : Collage.Shape
square =
    Collage.ngon 4 50


pentagon : Collage.Shape
pentagon =
    Collage.ngon 5 50


spacer : Collage.Collage msg
spacer =
    Layout.spacer 10 0


style : Collage.Shape -> Collage.Collage msg
style shape =
    let
        fillColor =
            Collage.uniform Color.lightGreen
        lineStyle =
            { defaultLineStyle
            |  fill = Collage.uniform Color.lightBlue
            , thickness = 3.0
            }
    in
    Collage.styled (fillColor, lineStyle) shape


main : Html msg
main =
    [ triangle, square, pentagon ]
        |> List.map style
        |> List.intersperse spacer
        |> Layout.horizontal
        |> Render.svg

