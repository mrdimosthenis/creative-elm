module Figures.Fig60 exposing (..)


import Html exposing (Html)
import Vector2d
import Browser
import TypedSvg
import TypedSvg.Core as Svg exposing (Svg)
import TypedSvg.Attributes as Attr
import TypedSvg.Attributes.InPx as PxAttr
import TypedSvg.Types as SvgTypes
import Color exposing (Color)
import Random
import Random.Float as RandFl


-- MAIN


main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }


-- MODEL


type alias Model =
  Svg Msg


init : () -> (Model, Cmd Msg)
init _ =
    (empty, Random.generate System (particleSystem 40 5))


-- UPDATE


type Msg
  = System (Svg Msg)


update : Msg -> Model -> (Model, Cmd Msg)
update msg _ =
  case msg of
    System system ->
      ( system, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    TypedSvg.svg
        []
        [ model ]


-- Actual Implementation


empty : Svg.Svg msg
empty =
    TypedSvg.g [] []


step : Vector2d.Vector2d -> Random.Generator Vector2d.Vector2d
step point =
    let
        drift =
            (10.0, 10.0)
            |> Vector2d.fromComponents
            |> Vector2d.sum point
        noise =
            RandFl.normal 0.0 5.0
            |> Random.andThen
                    (\x ->
                        RandFl.normal 0.0 5.0
                        |> Random.map (\y -> Vector2d.fromComponents (x, y))
                    )
    in
    Random.map (\vec -> Vector2d.sum drift vec) noise


render : Vector2d.Vector2d -> Svg.Svg msg
render point =
    let
        r =
            Vector2d.length point
        hue =
            turns (r / 500)
        color =
            Color.hsla hue 0.7 0.5 0.5
    in
    TypedSvg.circle
        [ PxAttr.cx (Vector2d.xComponent point)
        , PxAttr.cy (Vector2d.yComponent point)
        , PxAttr.r (r / 20)
        , Attr.fill (SvgTypes.Fill color)
        ]
        []


loop : Int -> Vector2d.Vector2d -> Svg.Svg msg -> Random.Generator (Svg.Svg msg)
loop n point circle =
    case n of
        0 -> point
             |> render
             |> Random.constant
        _ -> point
             |> step
             |> Random.andThen
                    (\pt ->
                        [ render point, circle ]
                        |> TypedSvg.g []
                        |> loop (n - 1) pt
                    )


walk : Int -> Random.Generator (Svg.Svg msg)
walk n =
    Vector2d.zero
    |> Random.constant
    |> Random.andThen (\pt -> loop n pt empty)


particleSystem : Int -> Int -> Random.Generator (Svg.Svg msg)
particleSystem particles steps =
    case particles of
        0 -> Random.constant empty
        _ -> steps
             |> walk
             |> Random.andThen
                    (\img1 ->
                        particleSystem (particles - 1) steps
                        |> Random.map (\img2 -> TypedSvg.g [] [ img1, img2 ])
                    )

