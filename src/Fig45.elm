module Figures.Fig45 exposing (main, polarToCartecian, star)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Html exposing (Html)
import Vector2d


polarToCartecian : ( Float, Float ) -> ( Float, Float )
polarToCartecian ( r, theta ) =
    ( r, theta )
        |> Vector2d.fromPolarComponents
        |> Vector2d.components


star : Int -> Int -> Float -> Collage.Collage msg
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
        |> Collage.outlined { defaultLineStyle | thickness = 2.0 }


main : Html msg
main =
    List.range 1 5
        |> List.map (\n -> star 11 n 100)
        |> Layout.horizontal
        |> Render.svg
