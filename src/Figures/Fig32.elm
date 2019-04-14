module Figures.Fig32 exposing (..)


import Html exposing (Html)
import Svg
import Svg.Attributes as Attr


dotAt : Int -> Int -> Svg.Svg msg
dotAt x y =
    Svg.circle
        [ Attr.cx (String.fromInt x)
        , Attr.cy (String.fromInt y)
        , Attr.r "5"
        , Attr.stroke "crimson"
        , Attr.strokeWidth "3"
        , Attr.fill "none"
        ]
        []


main : Html msg
main =
    Svg.svg
        []
        [ dotAt 0 0
        , dotAt 100 0
        , dotAt 0 100
        , dotAt 100 100
        ]

