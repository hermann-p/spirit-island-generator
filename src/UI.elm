module UI exposing (..)

import Element exposing (Element, behindContent, centerX, centerY, el, fill, height, mouseDown, mouseOver, none, padding, paddingEach, px, rgb, row, spacing, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onClick)
import Element.Font as Font
import Element.Input as Input
import MC


palette =
    { white = MC.grey50
    , text = MC.grey800
    , primary =
        { fg = MC.green500
        , bg = MC.green50
        }
    , secondary =
        { fg = MC.purple400
        , bg = MC.purple50
        }
    , contrast =
        { fg = MC.blue50
        , bg = MC.blue500
        }
    }


theme =
    { primary =
        {}
    , interactive =
        { base = { text = palette.primary.fg, bg = palette.primary.bg, border = palette.primary.fg }
        , hover = { text = palette.text, bg = palette.primary.bg, border = palette.primary.fg }
        , active = { text = palette.secondary.fg, bg = palette.secondary.bg, border = palette.secondary.fg }
        , disabled = { text = MC.grey500, bg = MC.grey50, border = MC.grey500 }
        }
    }


imageToggle : { onPress : msg, label : Element msg, disabled : Bool, active : Bool } -> Element msg
imageToggle cfg =
    let
        colors =
            if cfg.active then
                theme.interactive.base

            else
                theme.interactive.disabled
    in
    Input.button
        [ width fill
        , padding 4
        , Background.color colors.bg
        , Font.color colors.text
        , Border.color colors.border
        , Border.width 2
        , Border.rounded 4
        , mouseOver
            [ Background.color theme.interactive.hover.bg
            , Font.color theme.interactive.hover.text
            , Border.color theme.interactive.hover.border
            ]
        , mouseDown
            [ Background.color theme.interactive.active.bg
            , Font.color theme.interactive.active.text
            , Border.color theme.interactive.active.border
            ]
        ]
        { onPress =
            if cfg.disabled then
                Nothing

            else
                Just cfg.onPress
        , label = row [ width fill, spacing 8 ] [ Input.defaultCheckbox cfg.active, cfg.label ]
        }


button : { onPress : msg, label : Element msg, disabled : Bool } -> Element msg
button cfg =
    let
        colors =
            if cfg.disabled then
                theme.interactive.disabled

            else
                theme.interactive.base
    in
    Input.button
        [ width fill
        , padding 16
        , Background.color colors.bg
        , Font.color colors.text
        , Border.color colors.border
        , Border.width 2
        , Border.rounded 4
        , mouseOver
            [ Background.color theme.interactive.hover.bg
            , Font.color theme.interactive.hover.text
            , Border.color theme.interactive.hover.border
            ]
        , mouseDown
            [ Background.color theme.interactive.active.bg
            , Font.color theme.interactive.active.text
            , Border.color theme.interactive.active.border
            ]
        ]
        { onPress =
            if cfg.disabled then
                Nothing

            else
                Just cfg.onPress
        , label = cfg.label
        }


intSlider : { label : Input.Label msg, min : Int, max : Int, step : Int, value : Int, onChange : Int -> msg } -> Element msg
intSlider cfg =
    Input.slider
        [ height (px 96)
        , behindContent <|
            el
                [ width fill
                , height (px 2)
                , centerY
                , Background.color MC.grey300
                , Border.rounded 4
                ]
                Element.none
        ]
        { label = cfg.label
        , min = toFloat cfg.min
        , max = toFloat cfg.max
        , onChange = round >> cfg.onChange
        , step = Just <| toFloat cfg.step
        , thumb =
            Input.thumb
                [ width (px 64)
                , height (px 64)
                , Border.width 3
                , Border.rounded 32
                , Border.color theme.interactive.base.border
                , Background.color theme.interactive.base.bg
                ]
        , value = toFloat cfg.value
        }


tabItem : { toElement : a -> Element msg, onClick : a -> msg, isSelected : Bool } -> a -> Element msg
tabItem ({ toElement, isSelected } as cfg) item =
    let
        padOffset =
            if isSelected then
                0

            else
                2

        borderWidths =
            if isSelected then
                { left = 2, top = 2, right = 2, bottom = 0 }

            else
                { bottom = 2, top = 0, left = 0, right = 0 }

        corners =
            if isSelected then
                { topLeft = 6, topRight = 6, bottomLeft = 0, bottomRight = 0 }

            else
                { topLeft = 0, topRight = 0, bottomLeft = 0, bottomRight = 0 }
    in
    el
        [ Border.widthEach borderWidths
        , Border.roundEach corners
        , Border.color MC.blue300
        , onClick <| cfg.onClick item
        ]
    <|
        el
            [ centerX
            , centerY
            , paddingEach { left = 30, right = 30, top = 10 + padOffset, bottom = 10 - padOffset }
            ]
        <|
            toElement item


tabRibbon : { toElement : a -> Element msg, onClick : a -> msg, selected : a } -> List a -> Element msg
tabRibbon { toElement, onClick, selected } xs =
    row [ width fill ] (List.map (\a -> tabItem { toElement = toElement, onClick = onClick, isSelected = a == selected } a) xs)
