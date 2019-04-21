module Figures.Fig34 exposing (..)


import Html exposing (Html)
import Vector2d
import Svg
import Svg.Attributes as Attr


triangleAt : Vector2d.Vector2d -> Svg.Svg msg
triangleAt point =
    let
        x =
            point |> Vector2d.xComponent |> truncate |> String.fromInt
        y =
            point |> Vector2d.yComponent |> truncate |> String.fromInt
    in
    Svg.svg
        [ Attr.x x
        , Attr.y y
        ]
        [ Svg.polyline
            [ Attr.fill "none"
            , Attr.stroke "black"
            , Attr.points "5,0 0,10 10,10 5,0"
            ]
            []
        ]


dotAtParamCircle : Float -> Svg.Svg msg
dotAtParamCircle angle =
    (200, angle)
        |> Vector2d.fromPolarComponents
        |> Vector2d.sum (Vector2d.fromComponents (200, 200))
        |> triangleAt


loop : Float -> Int -> Svg.Svg msg
loop step count =
    let
        angle =
            step * toFloat count
    in
    case count of
        0 -> Svg.g [] []
        _ -> Svg.g [] [ dotAtParamCircle angle, loop step (count - 1) ]


sample : Int -> Svg.Svg msg
sample n =
    let
        step =
            degrees 360 / toFloat n
    in
    loop step n



main : Html msg
main =
    Svg.svg
        [ Attr.width "410"
        , Attr.height "410"
        ]
        [ sample 72 ]

