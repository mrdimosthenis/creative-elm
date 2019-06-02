module Figures.Fig28 exposing (circle, concentricCircles, main)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


circle : Int -> Collage.Collage msg
circle size =
    size
        |> toFloat
        |> Collage.circle
        |> Collage.outlined { defaultLineStyle | fill = Collage.uniform Color.blue }


concentricCircles : Int -> Int -> Collage.Collage msg
concentricCircles n size =
    case n of
        0 ->
            Layout.empty

        _ ->
            concentricCircles (n - 1) (size + 5)
                |> List.singleton
                |> (::) (circle size)
                |> Layout.stack


main : Html msg
main =
    Render.svg (concentricCircles 20 30)
