module Figures.Fig01 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render


main : Html msg
main =
    Collage.circle 10
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg

