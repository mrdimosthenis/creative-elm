module Figures.Fig16 exposing (..)


import Html exposing (Html)
import Collage exposing (defaultLineStyle)
import Collage.Render as Render
import Collage.Layout as Layout
import Color


main : Html msg
main =
    let
        circles =
            List.map3
                (\r c l ->
                    Collage.styled
                        ( Collage.uniform c
                        , l
                        )
                        (Collage.circle r))
                [ 10, 20, 30 ]
                [ Color.red, Color.white, Color.red ]
                [ defaultLineStyle, defaultLineStyle, { defaultLineStyle | thickness = 2.0 }]
                |> Layout.stack
        base =
            Collage.rectangle 20 6
                |> Collage.styled
                    ( Collage.uniform Color.brown
                    , defaultLineStyle
                    )
                |> List.singleton
                |> (::) (Collage.outlined defaultLineStyle (Collage.rectangle 6 20))
                |> Layout.vertical
        field =
            Collage.filled (Collage.uniform Color.green) (Collage.rectangle 80 25)
    in
    [ circles, base, field ]
        |> Layout.vertical
        |> Render.svg

