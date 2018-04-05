module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main : Program Never Model Msg
main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { reverse : Bool
    , value : String
    }


model : Model
model =
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
                    , value = (String.reverse model.value)
                }

        Mimic content ->
            if model.reverse then
                { model | value = (String.reverse content) }
            else
                { model | value = content }



-- VIEW


view : Model -> Html Msg
view model =
    fieldset []
        [ checkbox ToggleReverse
            "Reverse"
        , input
            [ placeholder "Type Something!", onInput Mimic, myStyle ]
            []
        , div [ myStyle ] [ text (toString model) ]
        ]


myStyle : Attribute msg
myStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "40px" )
        , ( "padding", "10px 0" )
        , ( "font-size", "2em" )
        , ( "text-align", "center" )
        ]


checkbox : msg -> String -> Html msg
checkbox msg name =
    label
        [ style [ ( "padding", "20px" ) ]
        ]
        [ input [ type_ "checkbox", onClick msg ] []
        , text name
        ]
