module Figures.Fig46 exposing (iter, main, polarToCartecian, star, style)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)
import Vector2d


polarToCartecian : ( Float, Float ) -> ( Float, Float )
polarToCartecian ( r, theta ) =
    ( r, theta )
        |> Vector2d.fromPolarComponents
        |> Vector2d.components


star : Int -> Int -> Float -> Collage.Shape
star sides skip radius =
    let
        rotation =
            degrees 360 * toFloat skip / toFloat sides

        start =
            polarToCartecian ( radius, degrees 0 )

        elements =
            List.range 1 (sides - 1)
                |> List.map (\index -> polarToCartecian ( radius, rotation * toFloat index ))
    in
    [ [ start ]
    , elements
    , [ start ]
    ]
        |> List.concat
        |> Collage.path
        |> Collage.close


style : Collage.Shape -> Float -> Collage.Collage msg
style shape hue =
    let
        lineColor =
            Color.hsla hue 1.0 0.25 1.0
                |> Collage.uniform

        lineStyle =
            { defaultLineStyle
                | fill = lineColor
            }
    in
    Collage.outlined lineStyle shape


iter : Int -> Collage.Collage msg
iter sides =
    sides
        // 2
        |> List.range 1
        |> List.map
            (\skip ->
                style (star sides skip 20) (degrees 360 * toFloat skip / toFloat sides)
            )
        |> Layout.horizontal
        |> Layout.align Layout.base


main : Html msg
main =
    List.range 3 33
        |> List.filter (\i -> modBy 2 i == 1)
        |> List.map iter
        |> Layout.vertical
        |> Render.svg
