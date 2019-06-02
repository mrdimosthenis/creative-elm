module Figures.Fig06 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout
import Color


main : Html msg
main =
    [ Collage.circle 10
        |> Collage.filled (Collage.uniform Color.black)
    , Collage.circle 20
        |> Collage.filled (Collage.uniform Color.lightBlue)
    , Collage.circle 30
        |> Collage.filled (Collage.uniform Color.white)
    , Collage.circle 50
        |> Collage.filled (Collage.uniform Color.darkBlue)
    ]
        |> Layout.stack
        |> Render.svg

