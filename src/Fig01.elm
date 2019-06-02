module Figures.Fig01 exposing (main)

import Collage
import Collage.Render as Render
import Html exposing (Html)


main : Html msg
main =
    Collage.circle 10
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg
