module Timer exposing (main)

import Browser
import Html exposing (Html, div, text)
import Task
import Time exposing (utc)


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


type alias Model =
    { timezone : Time.Zone
    , currentTime : Time.Posix
    , readableTime : String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Time.utc (Time.millisToPosix 0) ""
    , Cmd.batch
        [ Task.perform AdjustTimeZone Time.here
        , Task.perform Tick Time.now
        ]
    )


type Msg
    = Tick Time.Posix
    | AdjustTimeZone Time.Zone


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Tick newTime ->
            let
                hour =
                    String.fromInt (Time.toHour model.timezone model.currentTime)

                minute =
                    String.fromInt (Time.toMinute model.timezone model.currentTime)

                second =
                    String.fromInt (Time.toSecond model.timezone model.currentTime)

                readableTime =
                    hour ++ ":" ++ minute ++ ":" ++ second
            in
            ( { model
                | currentTime = newTime
                , readableTime = readableTime
              }
            , Cmd.none
            )

        AdjustTimeZone zone ->
            ( { model | timezone = zone }, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text model.readableTime ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Time.every 1000 Tick



-- Remember: Mutability
