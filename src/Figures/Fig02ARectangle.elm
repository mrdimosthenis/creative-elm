module Figures.Fig02ARectangle exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render


main : Html msg
main =
    Collage.rectangle 100 50
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg

