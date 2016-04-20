module Counter where

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model = Int

type Action = Increment | Decrement

update : Action -> Model -> Model
update action model =
    case action of
        Increment -> Model + 1
        Decrement -> Model - 1
        
view : Signal.Address Action -> Model -> Html
view address model =
    div []
        [ button [ onClick address Decrement ] [ text "-" ]
        , div [  ]
        ]
        