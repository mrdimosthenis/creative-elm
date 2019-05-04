module Figures.Fig32 exposing (..)


import Html exposing (Html)
import TypedSvg
import TypedSvg.Core as Svg
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Types as SvgTypes
import Color

dotAt : Float -> Float -> Svg.Svg msg
dotAt x y =
    TypedSvg.circle
        [ PxAttr.cx x
        , PxAttr.cy y
        , PxAttr.r 5.0
        , Attr.stroke Color.red
        , PxAttr.strokeWidth 3.0
        , Attr.fill SvgTypes.FillNone
        ]
        []


main : Html msg
main =
    TypedSvg.svg
        []
        [ dotAt 10.0 10.0
        , dotAt 110.0 10.0
        , dotAt 10.0 110.0
        , dotAt 110.0 110.0
        ]

