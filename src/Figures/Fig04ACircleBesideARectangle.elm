module Figures.Fig04ACircleBesideARectangle exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout


main : Html msg
main =
    let
        circle =
            Collage.circle 10
                |> Collage.outlined Collage.defaultLineStyle
        rectangle =
            Collage.rectangle 10 20
                |> Collage.outlined Collage.defaultLineStyle
    in
    Layout.beside Layout.Right circle rectangle
        |> Render.svg

