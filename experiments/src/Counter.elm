module Counter exposing (Model, Msg(..), init, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

type alias Model =
    { count : Int }

init : Model
init =
    Model 0

type Msg
    = Increment
    | Decrement

update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (String.fromInt model.count) ]
        , button [ onClick Increment ] [ text "+" ]
        ]

main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }
