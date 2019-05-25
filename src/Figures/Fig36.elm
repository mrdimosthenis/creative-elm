module Figures.Fig36 exposing (..)


import Html exposing (Html)
import Collage exposing (defaultLineStyle)
import Collage.Render as Render
import Collage.Layout as Layout
import Color


concentricShapes : Int -> (Int -> Collage.Collage msg) -> Collage.Collage msg
concentricShapes n shape =
    case n of
        0 -> Layout.empty
        _ -> concentricShapes (n - 1) shape
                |> List.singleton
                |> (::) (shape n)
                |> Layout.stack


colored : (Int -> Collage.Shape) -> (Int -> Color.Color) -> (Int -> Collage.Collage msg)
colored shape color =
    \n ->
        let
            lineStyle =
                { defaultLineStyle
                | fill = Collage.uniform (color n)
                , thickness = 4
                }
        in
        Collage.outlined lineStyle (shape n)


fading : Int -> Color.Color
fading n =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla Color.blue
        r =
            1.0 - (toFloat n / 20.0)
    in
    Color.hsla hue saturation lightness (alpha * (1 - r))


spinning : Int -> Color.Color
spinning n =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla Color.blue
        newHue =
            n * 5
                |> toFloat
                |> degrees
                |> (+) hue
    in
    Color.hsla newHue saturation lightness alpha


size : Int -> Float
size n =
    toFloat (50 + 12 * n)


circle : Int -> Collage.Shape
circle n =
    Collage.circle (size n)


square : Int -> Collage.Shape
square n =
    Collage.rectangle (2 * size n) (2 * size n)


triangle : Int -> Collage.Shape
triangle n =
    Collage.triangle (2 * size n)


main : Html msg
main =
    [ colored circle spinning
    , colored triangle fading
    , colored square spinning
    ]
        |> List.map (concentricShapes 10)
        |> Layout.horizontal
        |> Render.svg

