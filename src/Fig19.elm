module Figures.Fig19 exposing (main)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


main : Html msg
main =
    let
        roof =
            Collage.triangle 50
                |> Collage.filled (Collage.uniform Color.brown)

        frontDoor =
            Collage.rectangle 50 25
                |> Collage.filled (Collage.uniform Color.red)
                |> List.singleton
                |> (::) (Collage.filled (Collage.uniform Color.black) (Collage.rectangle 10 25))
                |> Layout.stack
                |> List.singleton
                |> (::) (Collage.filled (Collage.uniform Color.red) (Collage.rectangle 50 15))
                |> Layout.vertical

        house =
            [ roof, frontDoor ]
                |> Layout.vertical
                |> Layout.align Layout.bottom

        tree =
            Collage.rectangle 10 20
                |> Collage.filled (Collage.uniform Color.brown)
                |> List.singleton
                |> (::) (Collage.filled (Collage.uniform Color.green) (Collage.circle 25))
                |> Layout.vertical
                |> Layout.align Layout.bottom

        streetSegment =
            Collage.rectangle 15 3
                |> Collage.filled (Collage.uniform Color.black)
                |> List.singleton
                |> (::) (Collage.filled (Collage.uniform Color.yellow) (Collage.rectangle 30 3))
                |> Layout.horizontal
                |> Layout.align Layout.base
                |> List.singleton
                |> (::) (Collage.filled (Collage.uniform Color.black) (Collage.rectangle 45 6))
                |> List.reverse
                |> Layout.vertical

        street =
            List.repeat 3 streetSegment
                |> Layout.horizontal
                |> Layout.align Layout.base

        houseAndGarden =
            [ house, tree ]
                |> Layout.horizontal
                |> Layout.align Layout.base
                |> List.singleton
                |> (::) street
                |> List.reverse
                |> Layout.vertical
    in
    List.repeat 3 houseAndGarden
        |> Layout.horizontal
        |> Render.svg
