module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)

main : Program Never number Msg
main =
  beginnerProgram { model = 0, view = view, update = update }

view : a -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , span [] [ text (toString model) ]
    , button [onClick Increment] [ text "+" ]
    ]

type Msg = Increment | Decrement

update : Msg -> number -> number
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1