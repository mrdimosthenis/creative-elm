module Figures.Fig05 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout


main : Html msg
main =
    let
        smallCircle =
            Collage.circle 20
                |> Collage.outlined Collage.defaultLineStyle
        largeCircle =
            Collage.circle 60
                |> Collage.outlined Collage.defaultLineStyle
    in
    [ smallCircle
    , smallCircle
    , smallCircle
    ]
        |> Layout.horizontal
        |> Layout.align Layout.base
        |> List.singleton
        |> (::) largeCircle
        |> Layout.stack
        |> Render.svg

