module Figures.Fig17 exposing (main, spin)

import Collage exposing (defaultLineStyle)
import Collage.Layout as Layout
import Collage.Render as Render
import Color
import Html exposing (Html)


spin : Float -> Color.Color -> Color.Color
spin angle color =
    let
        { hue, saturation, lightness, alpha } =
            Color.toHsla color
    in
    Color.hsla (hue + angle) saturation lightness alpha


main : Html msg
main =
    let
        box =
            Collage.rectangle 40 40
                |> Collage.styled
                    ( Color.lightBlue
                        |> spin (degrees 30)
                        |> Collage.uniform
                    , { defaultLineStyle | fill = Collage.uniform Color.darkBlue }
                    )
    in
    List.repeat 5 box
        |> Layout.horizontal
        |> Render.svg
