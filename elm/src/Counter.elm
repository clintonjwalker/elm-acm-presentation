module Counter exposing (main)

import Browser
import Factorial exposing (factorial)
import FizzBuzz exposing (buzzing)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)



-- The Elm architecture is used as the basis for many other front-end frameworks.
-- The difference in Elm is that every Elm program MUST follow it.
--
-- Here is our "Main" method. This defines our entire page.
-- init is the initial state of our model
-- update listens for Messages sent, and determines how to update our model accordingly.
-- view is the layout. It has access to the Model, and can Send messages
-- subscriptions are how we handle outside listeners (things we didn't send as Messages).
-- It is also how we can communicate *safely* to javascript
--
-- https://package.elm-lang.org/packages/elm/browser/latest/


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- React.useState({});
-- init ----------^
--
-- const [ value, setValue ] = React.useState("");
-- update --------^
--
-- return render ( <div> test </div> );
-- view -----------^
--
-- React.useEffect(() => {}, [ value ] );
-- subscriptions --^


type alias Model =
    Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )



-- Define our Message type (Msg)


type Msg
    = Increment
    | Decrement
    | IncrementBy Int



-- Update begins with a message, and the current state of the model.
-- It then returns a *new model*.
-- The Cmd Msg here allows us to trigger outside effects, or call out to
-- javascript.


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )

        IncrementBy n ->
            ( model + n, Cmd.none )



-- Everyhing is a function. Even the Layout.
-- Most Html Elements take 2 arguments: A list of Html Attributes, and
-- a list of child Html Elements.


view : Model -> Html Msg
view model =
    div []
        -- <div>
        [ button [ onClick Decrement ] [ text "-" ] -- <button onClick="">-</button>
        , div [] [ text <| String.fromInt model ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick (IncrementBy 5) ] [ text "+ 5" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
