module Figures.Fig09 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Color


main : Html msg
main =
    let pastelRed =
            Color.hsl (degrees 0) 0.8 0.6
                |> Collage.uniform
    in
    Collage.triangle 60
        |> Collage.filled pastelRed
        |> Render.svg

