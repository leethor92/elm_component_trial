module Gallery exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, img, ul, li, button, text)
import Html.Attributes exposing (src, class, alt)
import Html.Events exposing (onClick)

-- MODEL

type alias Image =
    { id : Int
    , url : String
    , alt : String
    }

type alias Model =
    { images : List Image
    , selected : Maybe Image
    }

init : List Image -> Model
init imgs =
    { images = imgs, selected = Nothing }


-- UPDATE

type Msg
    = Select Int
    | Deselect

update : Msg -> Model -> Model
update msg model =
    case msg of
        Select id ->
            let
                selectedImage =
                    List.filter (\img -> img.id == id) model.images
                        |> List.head
            in
            { model | selected = selectedImage }

        Deselect ->
            { model | selected = Nothing }


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ viewSelected model.selected
        , ul [ class "gallery" ] (List.map viewThumbnail model.images)
        ]


viewSelected : Maybe Image -> Html Msg
viewSelected maybeImg =
    case maybeImg of
        Nothing ->
            text ""

        Just img ->
            div [ class "selected" ]
                [ button [ onClick Deselect ] [ text "× Close" ]
                , imgLarge img
                ]


viewThumbnail : Image -> Html Msg
viewThumbnail img =
    li [ onClick (Select img.id), class "thumb" ]
        [ imgSmall img ]


imgSmall : Image -> Html msg
imgSmall image =
    img [ src image.url, class "thumb-img", alt image.alt ] []


imgLarge : Image -> Html msg
imgLarge image =
    img [ src image.url, class "large-img", alt image.alt ] []
