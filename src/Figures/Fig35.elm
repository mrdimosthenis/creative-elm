module Figures.Fig35 exposing (..)


import Html exposing (Html)
import Vector2d
import Svg
import Svg.Attributes as Attr


dotAt : Vector2d.Vector2d -> Svg.Svg msg
dotAt point =
    let
        x =
            point |> Vector2d.xComponent |> truncate |> String.fromInt
        y =
            point |> Vector2d.yComponent |> truncate |> String.fromInt
    in
    Svg.circle
        [ Attr.cx x
        , Attr.cy y
        , Attr.r "1.5"
        , Attr.fill "blue"
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
        0 -> Svg.g [] []
        _ -> Svg.g [] [ rose angle, loop step (count - 1) ]


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
        [ sample 300 ]
