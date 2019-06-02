module Figures.Fig05 exposing (main)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Html exposing (Html)


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
