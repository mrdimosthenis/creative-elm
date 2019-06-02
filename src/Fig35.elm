module Figures.Fig35 exposing (..)


import Html exposing (Html)
import Vector2d
import TypedSvg
import TypedSvg.Core as Svg
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Types as SvgTypes
import Color


dotAt : Vector2d.Vector2d -> Svg.Svg msg
dotAt point =
    let
        (x, y) =
            Vector2d.components point
    in
    TypedSvg.circle
        [ PxAttr.cx x
        , PxAttr.cy y
        , PxAttr.r 1.5
        , Attr.fill (SvgTypes.Fill Color.blue)
        ]
        []


rose : Float -> Svg.Svg msg
rose angle =
    (200 * cos (angle * 7)
    , angle)
        |> Vector2d.fromPolarComponents
        |> Vector2d.sum (Vector2d.fromComponents (200, 200))
        |> dotAt


loop : Float -> Int -> Svg.Svg msg
loop step count =
    let
        angle =
            step * toFloat count
    in
    case count of
        0 -> TypedSvg.g [] []
        _ -> TypedSvg.g [] [ rose angle, loop step (count - 1) ]


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
        [ sample 300 ]

