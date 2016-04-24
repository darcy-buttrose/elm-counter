module CounterList (Model, init, Action, update, view) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Counter

-- MODEL

type alias ID = Int

type alias Model = 
    {
        counters : List (ID, Counter.Model),
        nextID : ID
    }

init: Model
init =
    {
        counters = [],
        nextID = 0
    }
    
-- ACTION

type Action =
    Insert |
    Remove ID |
    Modify ID Counter.Action
    
update: Action -> Model -> Model
update action model =
    case action of
        Insert ->
            let newCounter = ( model.nextID, Counter.init 0)
                newCounters = model.counters ++ [ newCounter ]
            in
                { model |
                    counters = newCounters,
                    nextID = model.nextID + 1    
                }
        Remove id ->
            { model |
                counters = List.filter (\(counterID, _) -> counterID /= id) model.counters
            }
        Modify id counterAction ->
            let updateCounter (counterID, counterModel) =
                if counterID == id
                    then (counterID, Counter.update counterAction counterModel)
                    else (counterID, counterModel)
            in
                {model |
                    counters = List.map updateCounter model.counters
                }
                
-- VIEW

viewCounter: Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id, model) =
    let context = 
        Counter.Context
            (Signal.forwardTo address (Modify id))
            (Signal.forwardTo address (always (Remove id)))
    in
        Counter.viewWithRemoveButton context model

view: Signal.Address Action -> Model -> Html
view address model =
    let insert = button [ onClick address Insert ] [ text "Add" ]
    in  div [] (insert :: List.map (viewCounter address) model.counters)