module Main exposing (Model, Msg(..), btnStyles, init, main, update, view)

import Browser
import Counter as Counter
import Functional as Functional
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Inputs as Inputs
import Logic as Logic
import Mimic as Mimic
import Rando as Rando


-- Need to rethink this approach I way over complicated the layout here
-- Problems with external components galore
-- MODEL


type Comp
    = Counter Counter.Model
    | Functional Functional.Model
    | Inputs Inputs.Model
    | Logic Logic.Model
    | Mimic Mimic.Model
    | Rando Rando.Model


type alias Model =
    { component : Comp
    }



-- INIT


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "", Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MSG


type Msg
    = NoOp
    | CountMsg Counter.Msg


btnStyles : List (Attribute msg)
btnStyles =
    [ style "font-weight" "600"
    , style "background-color" "#f0ad00"
    , style "border-radius" "5px"
    , style "color" "#000"
    , style "padding" "0.75rem"
    ]


stepCounter : Model -> Counter.Model -> Model
stepCounter model count =
    { model | component = Counter count }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "margin" "auto"
        , style "text-align" "center"
        ]
        [ h1 [] [ text "Components" ]
        , h2 [] [ text "Please click a button below" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Counter" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Functional" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Inputs" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Logic" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Mimic" ]
        , button (List.concat [ [ onClick CountMsg ], btnStyles ]) [ text "Random Roll" ]
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        NoOp ->
            ( model, Cmd.none )

        CountMsg msg ->
            case model.component of
                Counter count ->
                    ( stepCounter model (Counter.update msg count), Cmd.none )

                _ ->
                    ( model, Cmd.none )



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
