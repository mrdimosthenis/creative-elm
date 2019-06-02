module Figures.Fig38 exposing (circle, circleOnSquare, concentricShapes, main, outlinedCircle, square)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Html exposing (Html)


concentricShapes : Int -> (Int -> Collage.Collage msg) -> Collage.Collage msg
concentricShapes n shape =
    case n of
        0 ->
            Layout.empty

        _ ->
            concentricShapes (n - 1) shape
                |> List.singleton
                |> (::) (shape n)
                |> Layout.stack


circle : Int -> Collage.Shape
circle size =
    size
        |> toFloat
        |> Collage.circle


square : Int -> Collage.Shape
square size =
    let
        length =
            toFloat size
    in
    Collage.rectangle length length


outlinedCircle : Int -> Collage.Collage msg
outlinedCircle n =
    10
        * n
        |> toFloat
        |> Collage.circle
        |> Collage.outlined defaultLineStyle


circleOnSquare : Int -> Collage.Collage msg
circleOnSquare n =
    Collage.outlined defaultLineStyle <|
        if modBy 2 n == 0 then
            square (n * 20)

        else
            circle (n * 10)


main : Html msg
main =
    [ concentricShapes 10 outlinedCircle
    , concentricShapes 10 circleOnSquare
    ]
        |> Layout.horizontal
        |> Render.svg
