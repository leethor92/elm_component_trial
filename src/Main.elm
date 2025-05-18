module Main exposing (main)

import Browser
import Html exposing (Html, div, text)
import Gallery exposing (Model, Msg, init, update, view)

main =
    Browser.sandbox
        { init = init sampleImages
        , update = update
        , view = view
        }

sampleImages =
    [ { id = 1, url = "https://via.placeholder.com/200x150", alt = "Gallery Image 1" }
    , { id = 2, url = "https://via.placeholder.com/200x151", alt = "Gallery Image 2" }
    , { id = 3, url = "https://via.placeholder.com/200x152", alt = "Gallery Image 3" }
    ]
