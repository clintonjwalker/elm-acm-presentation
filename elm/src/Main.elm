module Main exposing (..)

import Browser
import Factorial exposing (factorial)
import FizzBuzz exposing (buzzing)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text <| String.fromInt model ]
        , button [ onClick Increment ] [ text "+" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
