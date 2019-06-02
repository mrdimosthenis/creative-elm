module Figures.Fig42 exposing (baseColor, coloredShape, lineStyle, main, makeImage, makeShape, spinning)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


lineStyle : Collage.LineStyle
lineStyle =
    { defaultLineStyle
        | fill = Collage.uniform Color.lightRed
        , thickness = 1.5
    }


baseColor : Color.Color
baseColor =
    Color.hsla (degrees 0.0) 0.7 0.7 1.0


spinning : Int -> Color.Color
spinning n =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla baseColor

        newHue =
            n
                * 5
                |> toFloat
                |> degrees
                |> (+) hue
    in
    Color.hsla newHue saturation lightness alpha


coloredShape : Int -> Collage.Shape -> Collage.Collage msg
coloredShape n shape =
    let
        color =
            Collage.uniform (spinning n)
    in
    Collage.styled ( color, lineStyle ) shape


makeShape : Int -> Int -> Collage.Shape
makeShape n increment =
    n
        * increment
        |> toFloat
        |> Collage.ngon (n + 2)


makeImage : Int -> Collage.Collage msg
makeImage n =
    case n of
        0 ->
            Layout.empty

        _ ->
            makeShape n 10
                |> coloredShape n
                |> Collage.rotate (toFloat n)
                |> List.singleton
                |> (::) (makeImage (n - 1))
                |> Layout.stack


main : Html msg
main =
    Render.svg (makeImage 15)
