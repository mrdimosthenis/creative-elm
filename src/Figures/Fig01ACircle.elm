module Figures.Fig01ACircle exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render


main : Html msg
main =
    Collage.circle 10
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg

