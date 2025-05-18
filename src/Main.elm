module Main exposing (main)

import Browser
import Gallery exposing (Model, Msg, init, update, view)
import Html exposing (Html, div, text)
import Http
import Json.Decode as Decode exposing (Decoder)


-- PRODUCT AND FETCHING --

type alias Product =
    { id : Int
    , title : String
    , price : Float
    , description : String
    , category : String
    , image : String
    }

productDecoder : Decoder Product
productDecoder =
    Decode.map6 Product
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "price" Decode.float)
        (Decode.field "description" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "image" Decode.string)

productsDecoder : Decoder (List Product)
productsDecoder =
    Decode.list productDecoder


-- MESSAGES --

type Msg
    = ProductsReceived (Result Http.Error (List Product))
    | GalleryMsg Gallery.Msg


-- MODEL --

type alias Model =
    { galleryModel : Gallery.Model
    , error : Maybe String
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { galleryModel = Gallery.init [], error = Nothing }
    , fetchProductsCmd
    )


-- FETCH COMMAND --

fetchProductsCmd : Cmd Msg
fetchProductsCmd =
    Http.get
        { url = "https://fakestoreapi.com/products"
        , expect = Http.expectJson ProductsReceived productsDecoder
        }


-- UPDATE --

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsReceived result ->
            case result of
                Ok products ->
                    -- Map Product list to Gallery.Image list
                    let
                        images =
                            List.map
                                (\p -> 
                                    { id = p.id
                                    , url = p.image
                                    , alt = p.title
                                    }
                                )
                                products
                    in
                    ( { model | galleryModel = Gallery.init images, error = Nothing }, Cmd.none )

                Err httpError ->
                    ( { model | error = Just (Debug.toString httpError) }, Cmd.none )

        GalleryMsg galleryMsg ->
            let
                updatedGallery = Gallery.update galleryMsg model.galleryModel
            in
            ( { model | galleryModel = updatedGallery }, Cmd.none )


-- VIEW --

view : Model -> Html Msg
view model =
    case model.error of
        Just err ->
            div [] [ text ("Error loading products: " ++ err) ]

        Nothing ->
            Html.map GalleryMsg (Gallery.view model.galleryModel)


-- MAIN --

main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
