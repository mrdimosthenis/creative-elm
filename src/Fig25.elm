module Figures.Fig25 exposing (main, sierpinski, triangle, triangulate)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


triangle : Collage.Collage msg
triangle =
    Collage.outlined
        { defaultLineStyle | fill = Collage.uniform Color.lightBlue }
        (Collage.triangle 10)


triangulate : Collage.Collage msg -> Collage.Collage msg
triangulate shape =
    [ shape, shape ]
        |> Layout.horizontal
        |> Layout.align Layout.base
        |> List.singleton
        |> (::) shape
        |> Layout.vertical
        |> Layout.align Layout.base


sierpinski : Int -> Collage.Collage msg
sierpinski n =
    case n of
        0 ->
            triangulate triangle

        _ ->
            let
                unit =
                    sierpinski (n - 1)
            in
            triangulate unit


main : Html msg
main =
    Render.svg (sierpinski 4)
