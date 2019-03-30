module Figures.Fig01ACircle exposing (..)


import Collage
import Collage.Render as Render


main =
    Collage.circle 10
        |> Collage.outlined Collage.defaultLineStyle
        |> Render.svg

