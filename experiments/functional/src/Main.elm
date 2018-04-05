module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { names : List String
    , nums : List Int
    , zipped : List ( String, Int )
    , lengthed : Int
    }


model : Model
model =
    Model [ "Tom", "Sue", "Bob" ] [ 45, 31, 26 ] [ ( "", 0 ) ] 0


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
        [ div [ myStyle ] [ text "Zipped: ", text (toString model.zipped) ]
        , div [ myStyle ] [ text "Length: ", text (toString model.lengthed) ]
        , button [ onClick RunZip, btnStyles ] [ text "Zip" ]
        , button [ onClick RunLength, btnStyles ] [ text "Length" ]
        , button [ onClick Reset, btnStyles ] [ text "Reset" ]
        ]



-- UPDATE


type Msg
    = RunZip
    | RunLength
    | Reset


stringList : List a -> List String
stringList val =
    List.map toString val


update : Msg -> Model -> Model
update msg model =
    case msg of
        RunZip ->
            { model | zipped = zip model.names model.nums }

        RunLength ->
            { model | lengthed = length (model.names ++ stringList model.nums) }

        Reset ->
            { model
                | zipped = [ ( "", 0 ) ]
                , lengthed = 0
            }


btnStyles : Attribute msg
btnStyles =
    style
        [ ( "width", "33%" )
        , ( "font-size", "1em" )
        , ( "text-align", "center" )
        , ( "padding", "10px 10px" )
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
