module Figures.AAColage exposing (..)

import Collage exposing (circle, rectangle, filled, uniform)
import Collage.Layout exposing (at, topLeft)
import Collage.Render exposing (svg)
import Color

main =
    let
        circ =
            circle 50
                |> filled (uniform Color.red)

        rect =
            rectangle 200 100
                |> filled (uniform Color.blue)
    in
    rect
        |> at topLeft circ
        |> svg
