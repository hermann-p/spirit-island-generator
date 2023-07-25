module UI exposing (..)

import Element exposing (Element, behindContent, centerY, el, fill, height, mouseDown, mouseOver, padding, px, rgb, width)
import Element.Background as Background
import Element.Border as Border
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
