module Figures.Fig03 exposing (main)

import Collage
import Collage.Render as Render
import Html exposing (Html)


main : Html msg
main =
    Collage.triangle 60
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg
