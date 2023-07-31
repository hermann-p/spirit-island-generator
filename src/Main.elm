module Main exposing (..)

import Browser
import Dict exposing (update)
import Element exposing (Element, centerX, centerY, column, el, fill, height, image, layout, padding, paddingXY, px, row, spacing, text, width)
import Element.Font as Font exposing (Font)
import Element.Input exposing (button, labelAbove, labelLeft, labelRight)
import Random exposing (generate)
import Random.List exposing (choices, choose)
import Spirits exposing (Spirit, spirits)
import String exposing (fromInt)
import Tools exposing (splitListFull)
import UI


maxPlayers : Int
maxPlayers =
    6


type alias Model =
    { poolOfSpirits : List Spirit
    , availableSpirits : List Spirit
    , nPlayers : Int
    , players : List Spirit
    , currentView : View
    }


initial : Model
initial =
    { nPlayers = 2
    , poolOfSpirits = spirits
    , availableSpirits = spirits
    , players = []
    , currentView = MainView
    }


type alias Flags =
    {}


type View
    = MainView
    | SettingsView


init : Flags -> ( Model, Cmd Msg )
init _ =
    update RollAllSpirits initial


type Msg
    = SetPlayers Int
    | RollAllSpirits
    | SetAllSpirits ( List Spirit, List Spirit )
    | RollSpirit Int
    | SetSpirit Int ( Maybe Spirit, List Spirit )
    | SetSpiritIsInPool Bool Spirit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetPlayers n ->
            ( { model | nPlayers = n }, Cmd.none )

        RollAllSpirits ->
            let
                spiritGenerator =
                    choices maxPlayers model.availableSpirits
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

        SetSpirit n ( Just chosen, _ ) ->
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
                    List.filter (\spirit -> not <| List.member spirit players) model.poolOfSpirits
            in
            ( { model | players = players, availableSpirits = availableSpirits }, Cmd.none )

        SetSpirit _ _ ->
            ( model, Cmd.none )

        SetSpiritIsInPool isInPool spirit ->
            let
                pool =
                    if isInPool then
                        model.poolOfSpirits ++ [ spirit ]

                    else
                        List.filter (\s -> s /= spirit) model.poolOfSpirits
            in
            update RollAllSpirits { model | poolOfSpirits = pool }


settingsView : model -> List (Element Msg)
settingsView _ =
    List.map spiritToggle spirits


toGrid : Int -> (a -> Element msg) -> List a -> Element msg
toGrid cols toElement xs =
    let
        emptyCol =
            column [ width fill ] [ text "" ]
    in
    if List.length xs < 2 then
        xs |> List.head |> Maybe.map toElement |> Maybe.withDefault emptyCol

    else
        xs
            |> List.map toElement
            |> splitListFull cols emptyCol
            |> List.map (row [ width fill, spacing 16, paddingXY 0 8 ])
            |> column [ width fill ]


selectList : { selected : List Spirit, options : List Spirit, onCheck : Bool -> Spirit -> msg } -> Element msg
selectList cfg =
    let
        selectElement : Spirit -> Element msg
        selectElement el =
            let
                checked =
                    List.member el cfg.selected
            in
            button [] { onPress = Just <| cfg.onCheck (not checked) el, label = image [ width fill ] { src = spiritToImageUrl el, description = el.name } }
    in
    toGrid 2 selectElement cfg.options


spiritToggle : Spirit -> Element Msg
spiritToggle spirit =
    image [] { description = spirit.name, src = spiritToImageUrl spirit }


selectPlayersView : Model -> Element Msg
selectPlayersView model =
    row [ width fill, centerY ]
        [ UI.intSlider
            { label = labelLeft [] <| row [ centerY, spacing 16, Font.size 64 ] [ image [ height <| px 96 ] { src = "/misc/Spiritsicon.png", description = "Spirits" }, text <| fromInt model.nPlayers ]
            , min = 1
            , max = maxPlayers
            , onChange = SetPlayers
            , step = 1
            , value = model.nPlayers
            }
        ]


spiritToImageUrl : Spirit -> String
spiritToImageUrl { name } =
    "spirits/" ++ String.filter Char.isAlpha name ++ ".png"


playerView : Int -> Spirit -> Element Msg
playerView idx spirit =
    button [ width fill ]
        { onPress = Just (RollSpirit idx)
        , label = image [ width fill ] { src = spiritToImageUrl spirit, description = spirit.name }
        }


mainView : Model -> List (Element Msg)
mainView model =
    [ selectPlayersView model
    , UI.button { onPress = RollAllSpirits, label = el [ centerX ] (text "Geister neu würfeln"), disabled = False }
    , List.take model.nPlayers model.players |> List.indexedMap playerView |> toGrid 2 identity
    ]


view : Model -> Browser.Document Msg
view model =
    let
        content =
            case model.currentView of
                MainView ->
                    mainView

                SettingsView ->
                    settingsView
    in
    { title = "Spirit Island game generator"
    , body =
        [ layout [ padding 16 ]
            (column [ width fill, spacing 32 ]
                (content model)
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
