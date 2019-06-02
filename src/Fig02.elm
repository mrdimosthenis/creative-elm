module Figures.Fig02 exposing (main)

import Collage
import Collage.Render as Render
import Html exposing (Html)


main : Html msg
main =
    Collage.rectangle 100 50
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg
