module Main exposing (Model, Msg(..), checkbox, init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)



-- MODEL


type alias Model =
    { reverse : Bool
    , value : String
    }


init : Model
init =
    Model False ""



-- UPDATE


type Msg
    = Mimic String
    | ToggleReverse


update : Msg -> Model -> Model
update msg model =
    case msg of
        ToggleReverse ->
            let
                isReverse =
                    not model.reverse
            in
            { model
                | reverse = isReverse
                , value = String.reverse model.value
            }

        Mimic content ->
            if model.reverse then
                { model | value = String.reverse content }

            else
                { model | value = content }



-- VIEW


view : Model -> Html Msg
view model =
    fieldset []
        [ checkbox ToggleReverse
            "Reverse"
        , input
            [ placeholder "Type Something!"
            , onInput Mimic
            , style "width" "100%"
            , style "height" "40px"
            , style "padding" "10px 0"
            , style "font-size" "2em"
            , style "text-align" "center"
            ]
            []
        , div
            [ style "width" "100%"
            , style "height" "40px"
            , style "padding" "10px 0"
            , style "font-size" "2em"
            , style "text-align" "center"
            ]
            [ text model.value ]
        ]


checkbox : msg -> String -> Html msg
checkbox msg name =
    label
        [ style "padding" "20px" ]
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }
