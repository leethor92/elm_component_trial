module Gallery exposing (Model, Msg(..), init, update, view)

import Html exposing (Html, div, img, ul, li, button, text)
import Html.Attributes exposing (src, class, alt)
import Html.Events exposing (onClick)


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
    , selected : Maybe Product
    }

init : List Product -> Model
init prods =
    { products = prods, selected = Nothing }


-- UPDATE

type Msg
    = Select Int
    | Deselect

update : Msg -> Model -> Model
update msg model =
    case msg of
        Select id ->
            let
                selectedProduct =
                    List.filter (\p -> p.id == id) model.products
                        |> List.head
            in
            { model | selected = selectedProduct }

        Deselect ->
            { model | selected = Nothing }


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ viewSelected model.selected
        , ul [ class "gallery grid grid-cols-5 gap-4 p-4 list-none m-0" ]
            (List.map viewProductCard model.products)
        ]


viewSelected : Maybe Product -> Html Msg
viewSelected maybeProd =
    case maybeProd of
        Nothing ->
            text ""

        Just p ->
            div [ class "fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50" ]
                [ div [ class "bg-white rounded-lg p-6 max-w-lg w-full relative" ]
                    [ button [ onClick Deselect, class "absolute top-2 right-2 text-gray-600 hover:text-gray-900 text-2xl font-bold" ] [ text "×" ]
                    , img [ src p.url, alt p.alt, class "w-full h-64 object-cover rounded" ] []
                    , div [ class "mt-4 font-bold text-lg" ] [ text p.title ]
                    , div [ class "text-orange-600 font-semibold mt-1" ] [ text ("$" ++ String.fromFloat p.price) ]
                    , div [ class "text-gray-700 mt-2" ] [ text p.description ]
                    ]
                ]


viewProductCard : Product -> Html Msg
viewProductCard p =
    li
        [ onClick (Select p.id)
        , class "cursor-pointer border rounded shadow hover:shadow-lg p-2 flex flex-col"
        ]
        [ img [ src p.url, alt p.alt, class "w-full h-40 object-cover rounded" ] []
        , div [ class "mt-2 font-semibold text-gray-800 truncate" ] [ text p.title ]
        , div [ class "text-orange-600 font-bold mt-1" ] [ text ("$" ++ String.fromFloat p.price) ]
        , div [ class "text-gray-600 text-sm mt-1 line-clamp-3" ] [ text p.description ]
        ]
