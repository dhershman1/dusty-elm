module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


type Either a b
    = Left a
    | Right b


type alias Model =
    { names : List String
    , nums : List Int
    , results : List ( String, Int )
    }


model : Model
model =
    Model [ "Tom", "Sue", "Bob" ] [ 45, 31, 26 ] [ ( "", 0 ) ]


zip : List a -> List b -> List ( a, b )
zip xs ys =
    case ( xs, ys ) of
        ( x :: xBack, y :: yBack ) ->
            ( x, y ) :: zip xBack yBack

        ( _, _ ) ->
            []


length : List a -> number
length list =
    case list of
        [] ->
            0

        first :: rest ->
            1 + length rest



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ span [ myStyle ] [ text (toString model) ]
        , button [ onClick RunZip, btnStyles ] [ text "Zip" ]
        , button [ onClick RunLength, btnStyles ] [ text "Length" ]
        ]



-- UPDATE


type Msg
    = RunZip
    | RunLength


ensureList : Int -> List ( String, Int )
ensureList val =
    [ ( "Length", val ) ]


stringList : List a -> List String
stringList val =
    List.map toString val


update : Msg -> Model -> Model
update msg model =
    case msg of
        RunZip ->
            { model | results = zip model.names model.nums }

        RunLength ->
            { model | results = ensureList (length (model.names ++ stringList model.nums)) }


btnStyles : Attribute msg
btnStyles =
    style
        [ ( "width", "50%" )
        , ( "font-size", "1em" )
        , ( "text-align", "center" )
        , ( "padding", "10px 0" )
        ]


myStyle : Attribute msg
myStyle =
    style
        [ ( "width", "100%" )
        , ( "height", "40px" )
        , ( "padding", "20px 20px" )
        , ( "font-size", "2em" )
        , ( "text-align", "center" )
        ]
