module Figures.Fig04 exposing (main)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Html exposing (Html)


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
