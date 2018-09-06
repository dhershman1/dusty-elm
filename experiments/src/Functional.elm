module Functional exposing (Model, Msg(..), view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    { names : List String
    , nums : List Int
    , zipped : List ( String, Int )
    , lengthed : Int
    }


init : Model
init =
    Model [ "Tom", "Sue", "Bob" ] [ 45, 31, 26 ] [ ( "", 0 ) ] 0


zip : List a -> List b -> List ( a, b )
zip xs ys =
    List.map2 Tuple.pair xs ys


expand : ( String, Int ) -> Html msg
expand tup =
    span [] [ text (Tuple.first tup ++ " " ++ String.fromInt (Tuple.second tup)) ]



-- UPDATE


type Msg
    = RunZip
    | RunLength
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        RunZip ->
            { model | zipped = zip model.names model.nums }

        RunLength ->
            { model | lengthed = List.length model.names + List.length model.nums }

        Reset ->
            { model
                | zipped = [ ( "", 0 ) ]
                , lengthed = 0
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div myStyle (List.map expand model.zipped)
        , div myStyle [ text "Length: ", text (String.fromInt model.lengthed) ]
        , button (List.concat [ [ onClick RunZip ], btnStyles ]) [ text "Zip" ]
        , button (List.concat [ [ onClick RunLength ], btnStyles ]) [ text "Length" ]
        , button (List.concat [ [ onClick Reset ], btnStyles ]) [ text "Reset" ]
        ]


btnStyles : List (Attribute msg)
btnStyles =
    [ style "width" "33%"
    , style "font-size" "1em"
    , style "text-align" "center"
    , style "padding" "10px 10px"
    ]


myStyle : List (Attribute msg)
myStyle =
    [ style "width" "100%"
    , style "height" "40px"
    , style "font-size" "2em"
    , style "text-align" "center"
    , style "padding" "20px 20px"
    ]

-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, view = view, update = update }
