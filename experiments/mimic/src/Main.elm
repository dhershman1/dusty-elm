module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


type alias Model =
    { content : String }


init : Model
init =
    { content = "" }


view : Model -> Html Msg
view model =
    div []
        [ input
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
            [ text model.content ]
        ]


type Msg
    = Mimic String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Mimic newContent ->
            { model | content = newContent }


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }
