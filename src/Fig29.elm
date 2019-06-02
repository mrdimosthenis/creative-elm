module Figures.Fig29 exposing (circle, fadeCircles, fadeOut, gradientCircles, main, spin)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


circle : Int -> Color.Color -> Collage.Collage msg
circle size color =
    size
        |> toFloat
        |> Collage.circle
        |> Collage.outlined { defaultLineStyle | fill = Collage.uniform color }


fadeOut : Float -> Color.Color -> Color.Color
fadeOut r color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla hue saturation lightness (alpha * (1 - r))


spin : Float -> Color.Color -> Color.Color
spin angle color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + angle) saturation lightness alpha


fadeCircles : Int -> Int -> Color.Color -> Collage.Collage msg
fadeCircles n size color =
    case n of
        0 ->
            Layout.empty

        _ ->
            fadeOut 0.05 color
                |> fadeCircles (n - 1) (size + 7)
                |> List.singleton
                |> (::) (circle size color)
                |> Layout.stack


gradientCircles : Int -> Int -> Color.Color -> Collage.Collage msg
gradientCircles n size color =
    case n of
        0 ->
            Layout.empty

        _ ->
            spin (degrees 15) color
                |> gradientCircles (n - 1) (size + 7)
                |> List.singleton
                |> (::) (circle size color)
                |> Layout.stack


main : Html msg
main =
    [ fadeCircles 20 50 Color.red, gradientCircles 20 50 Color.lightBlue ]
        |> Layout.horizontal
        |> Render.svg
