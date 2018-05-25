module Main exposing (..)


import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Ports.LocalStorage as LS
import Json.Encode


type alias Model = Maybe Msg


type Msg
    = KeyRemoved (String, String)
    | KeyAdded (String, String)
    | KeyChanged (String, String, String)


main : Program Never Model Msg
main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }


view : Model -> Html Msg
view model =
    case model of
        Nothing ->
            div [] []

        Just (KeyAdded (key, value)) ->
            div []
                [ p [] [ text <| "Key added: " ++ key ]
                , p [] [ text <| "Value: " ++ value ]
                ]

        Just (KeyRemoved (key, value)) ->
            div []
                [ p [] [ text <| "Key removed: " ++ key ]
                , p [] [ text <| "Value: " ++ value ]
                ]

        Just (KeyChanged (key, oldValue, newValue)) ->
            div []
                [ p [] [ text <| "Key changed: " ++ key ]
                , p [] [ text <| "Old Value: " ++ oldValue ]
                , p [] [ text <| "New Value: " ++ newValue ]
                ]


init : (Model, Cmd Msg)
init =
    ( Nothing
    , LS.storageSetItem ("lastSearch", "fooBar")
    )


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (Just msg, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ LS.storageOnKeyAdded KeyAdded
        , LS.storageOnKeyRemoved KeyRemoved
        , LS.storageOnKeyChanged KeyChanged
        ]
