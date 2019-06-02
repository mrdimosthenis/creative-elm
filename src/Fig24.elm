module Figures.Fig24 exposing (base, blackSquare, chessBoard, main, redSquare)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


blackSquare : Collage.Collage msg
blackSquare =
    Collage.filled (Collage.uniform Color.black) (Collage.rectangle 30 30)


redSquare : Collage.Collage msg
redSquare =
    Collage.filled (Collage.uniform Color.red) (Collage.rectangle 30 30)


base : Collage.Collage msg
base =
    let
        topRow =
            [ redSquare, blackSquare ]
                |> Layout.horizontal
                |> Layout.align Layout.base

        bottomRow =
            [ blackSquare, redSquare ]
                |> Layout.horizontal
                |> Layout.align Layout.base
    in
    [ topRow, bottomRow ]
        |> Layout.vertical
        |> Layout.align Layout.base


chessBoard : Int -> Collage.Collage msg
chessBoard n =
    case n of
        0 ->
            base

        _ ->
            let
                unit =
                    chessBoard (n - 1)

                unitBesideUnit =
                    [ unit, unit ]
                        |> Layout.horizontal
                        |> Layout.align Layout.base
            in
            [ unitBesideUnit, unitBesideUnit ]
                |> Layout.vertical
                |> Layout.align Layout.base


main : Html msg
main =
    List.range 0 2
        |> List.map chessBoard
        |> List.intersperse (Layout.spacer 30 0)
        |> Layout.horizontal
        |> Layout.align Layout.base
        |> Render.svg
