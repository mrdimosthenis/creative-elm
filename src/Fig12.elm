module Figures.Fig12 exposing (main, transparent)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


transparent : Float -> Color.Color -> Color.Color
transparent alpha color =
    let
        { red, green, blue } =
            Color.toRgba color
    in
    Color.rgba red green blue alpha


main : Html msg
main =
    let
        circle color =
            Collage.circle 40
                |> Collage.filled (Collage.uniform color)

        twoCircles =
            [ Color.red, Color.blue ]
                |> List.map (circle << transparent 0.5)
                |> Layout.horizontal
                |> Layout.align Layout.base
                |> List.singleton
    in
    Color.green
        |> transparent 0.5
        |> circle
        |> List.singleton
        |> List.append twoCircles
        |> Layout.stack
        |> Render.svg
