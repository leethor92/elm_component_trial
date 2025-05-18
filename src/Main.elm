module Main exposing (main)

import Browser
import Gallery exposing (Model, init, view)
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
                    let
                        galleryProducts =
                            List.map
                                (\p ->
                                    { id = p.id
                                    , url = p.image
                                    , alt = p.title
                                    , title = p.title
                                    , price = p.price
                                    , description = p.description
                                    }
                                )
                                products
                    in
                    ( { model | galleryModel = Gallery.init galleryProducts, error = Nothing }, Cmd.none )

                Err httpError ->
                    ( { model | error = Just (Debug.toString httpError) }, Cmd.none )


-- VIEW --

view : Model -> Html Msg
view model =
    case model.error of
        Just err ->
            div [] [ text ("Error loading products: " ++ err) ]

        Nothing ->
            -- No need to Html.map since Gallery.view returns Html msg (generic)
            viewGallery model.galleryModel


viewGallery : Gallery.Model -> Html Msg
viewGallery galleryModel =
    Html.map (\_ -> Debug.todo "No messages") (Gallery.view galleryModel)


-- MAIN --

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
