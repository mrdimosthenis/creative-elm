module Figures.Fig14 exposing (main)

import Collage
import Collage.Layout as Layout
import Collage.Render as Render
import Html exposing (Html)


main : Html msg
main =
    let
        circles =
            [ 10, 20, 30 ]
                |> List.map
                    (\r ->
                        Collage.circle r
                            |> Collage.outlined Collage.defaultLineStyle
                    )
                |> Layout.stack
    in
    Collage.rectangle 20 6
        |> Collage.outlined Collage.defaultLineStyle
        |> List.singleton
        |> (::)
            (Collage.rectangle 6 20
                |> Collage.outlined Collage.defaultLineStyle
            )
        |> List.append [ circles ]
        |> Layout.vertical
        |> Render.svg
