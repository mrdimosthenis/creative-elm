module Figures.Fig26 exposing (growingBoxes, main, rectangle)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


rectangle : Float -> Float -> Collage.Collage msg
rectangle w h =
    Collage.styled
        ( Collage.uniform Color.lightBlue
        , { defaultLineStyle | fill = Collage.uniform Color.darkBlue }
        )
        (Collage.rectangle w h)


growingBoxes : Int -> Int -> Collage.Collage msg
growingBoxes count size =
    let
        floatSize =
            toFloat size
    in
    case count of
        0 ->
            Layout.empty

        _ ->
            growingBoxes (count - 1) (size + 10)
                |> List.singleton
                |> (::) (rectangle floatSize floatSize)
                |> Layout.horizontal


main : Html msg
main =
    Render.svg (growingBoxes 5 30)
