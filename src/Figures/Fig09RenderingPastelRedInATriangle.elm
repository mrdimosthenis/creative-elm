module Figures.Fig09RenderingPastelRedInATriangle exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Color
import Basics

main : Html msg
main =
    let pastelRed =
            Color.hsl (Basics.degrees 0) 0.8 0.6
                |> Collage.uniform
    in
    Collage.triangle 60
        |> Collage.filled pastelRed
        |> Render.svg
