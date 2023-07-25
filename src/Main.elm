module Main exposing (..)

import Browser
import Dict exposing (update)
import Element exposing (Element, centerX, column, el, fill, image, layout, padding, px, rgb, spacing, text, width)
import Element.Input as Input exposing (button, labelAbove)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import MC
import Random exposing (generate)
import Random.List exposing (choices, choose)
import Spirits exposing (Spirit, spirits)
import String exposing (fromInt)
import UI


type alias Model =
    { availableSpirits : List Spirit
    , nPlayers : Int
    , players : List Spirit
    }


initial : Model
initial =
    { nPlayers = 2, availableSpirits = spirits, players = [] }


type alias Flags =
    {}


init : Flags -> ( Model, Cmd Msg )
init _ =
    update RollAllSpirits initial


type Msg
    = NoOp
    | SetPlayers Int
    | RollAllSpirits
    | SetAllSpirits ( List Spirit, List Spirit )
    | RollSpirit Int
    | SetSpirit Int ( Maybe Spirit, List Spirit )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetPlayers n ->
            update RollAllSpirits { model | nPlayers = n }

        RollAllSpirits ->
            let
                spiritGenerator =
                    choices model.nPlayers spirits
            in
            ( model, generate SetAllSpirits spiritGenerator )

        RollSpirit n ->
            let
                spiritGenerator =
                    choose model.availableSpirits
            in
            ( model, generate (SetSpirit n) spiritGenerator )

        SetAllSpirits ( chosen, left ) ->
            ( { model | players = chosen, availableSpirits = left }, Cmd.none )

        SetSpirit n ( Just chosen, left ) ->
            let
                players =
                    List.indexedMap
                        (\idx spirit ->
                            if idx == n then
                                chosen

                            else
                                spirit
                        )
                        model.players

                availableSpirits =
                    List.filter (\spirit -> not <| List.member spirit players) spirits
            in
            ( { model | players = players, availableSpirits = availableSpirits }, Cmd.none )

        _ ->
            ( model, Cmd.none )


selectPlayersView : Model -> Element Msg
selectPlayersView model =
    UI.intSlider
        { label = labelAbove [] <| el [ centerX ] (text <| "Spieler: " ++ fromInt model.nPlayers)
        , min = 1
        , max = 5
        , onChange = SetPlayers
        , step = 1
        , value = model.nPlayers
        }


spiritToImageUrl : Spirit -> String
spiritToImageUrl { name } =
    "spirits/" ++ String.filter Char.isAlpha name ++ ".png"


playerView : Int -> Spirit -> Element Msg
playerView idx spirit =
    button [ width fill ]
        { onPress = Just (RollSpirit idx)
        , label = image [ width fill ] { src = spiritToImageUrl spirit, description = spirit.name }
        }


view : Model -> Browser.Document Msg
view model =
    { title = "Spirit Island game generator"
    , body =
        [ layout [ padding 32 ]
            (column [ width fill, spacing 32 ]
                ([ selectPlayersView model
                 , UI.button { onPress = RollAllSpirits, label = el [ centerX ] (text "Geister neu würfeln"), disabled = False }
                 ]
                    ++ List.indexedMap playerView model.players
                )
            )
        ]
    }


main =
    Browser.document
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
