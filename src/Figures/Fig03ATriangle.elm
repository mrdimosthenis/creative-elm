module Figures.Fig03ATriangle exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render


main : Html msg
main =
    Collage.triangle 60
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg

