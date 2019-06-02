module Figures.Fig34 exposing (..)


import Html exposing (Html)
import Vector2d
import TypedSvg
import TypedSvg.Core as Svg
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Types as SvgTypes
import Color


triangleAt : Vector2d.Vector2d -> Svg.Svg msg
triangleAt point =
    let
        (x, y) =
            Vector2d.components point
    in
    TypedSvg.svg
        [ PxAttr.x x
        , PxAttr.y y
        ]
        [ TypedSvg.polyline
            [ Attr.fill SvgTypes.FillNone
            , Attr.stroke Color.black
            , Attr.points [ (5.0, 0.0)
                          , (0.0, 10.0)
                          , (10.0, 10.0)
                          , (5.0, 0.0)
                          ]
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
        0 -> TypedSvg.g [] []
        _ -> TypedSvg.g [] [ dotAtParamCircle angle, loop step (count - 1) ]


sample : Int -> Svg.Svg msg
sample n =
    let
        step =
            degrees 360 / toFloat n
    in
    loop step n


main : Html msg
main =
    TypedSvg.svg
        [ PxAttr.width 410.0
        , PxAttr.height 410.0
        ]
        [ sample 72 ]

