module Figures.Fig23 exposing (..)


import Html exposing (Html)
import Collage
import Collage.Render as Render
import Collage.Layout as Layout


unit : Collage.Collage msg
unit =
    Collage.outlined Collage.defaultLineStyle (Collage.circle 20)


cross : Int -> Collage.Collage msg
cross n =
    case n of
        0 -> unit
        _ -> let
                inBetween = [ unit, cross (n - 1),  unit ]
                                |> Layout.vertical
                                |> Layout.align Layout.base
             in
             [ unit, inBetween, unit ]
                |> Layout.horizontal
                |> Layout.align Layout.base


main : Html msg
main =
    List.range 0 3
        |> List.map cross
        |> List.intersperse (Layout.spacer 20 0)
        |> Layout.horizontal
        |> Layout.align Layout.base
        |> Render.svg

