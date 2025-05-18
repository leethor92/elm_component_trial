module Gallery exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, img, li, text)
import Html.Attributes exposing (src, class, alt)


-- MODEL

type alias Product =
    { id : Int
    , url : String
    , alt : String
    , title : String
    , price : Float
    , description : String
    }

type alias Model =
    { products : List Product
    }


init : List Product -> Model
init prods =
    { products = prods }


-- UPDATE

type Msg
    = NoOp


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "gallery-container" ]
        (List.map viewProductCard model.products)

viewProductCard : Product -> Html Msg
viewProductCard product =
    li [ class "product-card" ]
        [ img [ src product.url, alt product.alt ] []
        , div [ class "product-title-price" ]
            [ div [ class "product-title" ] [ text product.title ]
            , div [ class "product-price" ] [ text ("$" ++ String.fromFloat product.price) ]
            ]
        , div [ class "product-description" ] [ text product.description ]
        ]


