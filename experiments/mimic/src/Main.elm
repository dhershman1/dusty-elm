module Main exposing (..)

import Html exposing (Html, Attribute, beginnerProgram, text, div, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main : Program Never String Msg
main =
    beginnerProgram { model = "", view = view, update = update }


view : a -> Html Msg
view model =
    div []
        [ input [ placeholder "Type Something!", onInput Mimic, myStyle ] []
        , div [ myStyle ] [ text (toString model) ]
        ]


type Msg
    = Mimic String


update : Msg -> a -> String
update (Mimic content) model =
    content


myStyle : Attribute msg
myStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "40px" )
        , ( "padding", "10px 0" )
        , ( "font-size", "2em" )
        , ( "text-align", "center" )
        ]
