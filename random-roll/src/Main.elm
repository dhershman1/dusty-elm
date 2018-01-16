module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dieFace : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    div [ myStyle ]
        [ h1 [] [ text (toString model.dieFace) ]
        , button [ onClick Roll ] [ text "Roll" ]
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
