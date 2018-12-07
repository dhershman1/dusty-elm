module Main exposing (main)

-- NOTE: Make sure to follow the instructions in the README for part3
-- to install the elm/browser package before running elm make!
--
-- FYI: 👇 You can see our new `Article` module in `src/Article.elm`

-- import Article
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL


initialModel =
    { tags = [ "elm"
    , "fun"
    , "programming"
    , "dragons"
    ]
    , selectedTag = "elm"
    , allArticles = [ { title = "Elm is fun!", description = "Elm", body = "I've really been enjoying it!", tags = [ "elm", "fun" ], slug = "elm-is-fun--zb6nba" }
    , { title = "Who says undefined isn't a function anyway?", description = "Functions", body = "Quite frankly I think undefined can be anything it wants to be,if it believes in itself.", slug = "who-says-undefined-isnt-a-function-anyway-t39ope", tags = [ "programming" ] }
    , { title = "This compiler is pretty neat", description = "Elm", body = "It tells me about problems in my code. How neat is that?", tags = [ "compilers", "elm" ], slug = "this-compiler-is-pretty-neat-9ycui8" }
    , { title = "Are dragons real?", description = "dragons", body = "Do Komodo Dragons count? I think they should. It's right there in the name!", tags = [ "dragons" ], slug = "are-dragons-real-467lsh" }
    ]
    }



-- UPDATE


update msg model =
    if msg.description == "ClickedTag" then
        { model | selectedTag = msg.data }
    else
        model


-- VIEW


view model =
    let
        articles =
            List.filter (\article -> List.member model.selectedTag article.tags)
                model.allArticles

        feed =
            List.map viewArticle articles
    in
    div [ class "home-page" ]
        [ viewBanner
        , div [ class "container page" ]
            [ div [ class "row" ]
                [ div [ class "col-md-9" ] feed
                , div [ class "col-md-3" ]
                    [ div [ class "sidebar" ]
                        [ p [] [ text "Popular Tags" ]
                        , viewTags model
                        ]
                    ]
                ]
            ]
        ]


viewArticle article =
    div [ class "article-preview" ]
        [ h1 [] [ text article.title ]
        , p [] [ text article.description ]
        , span [] [ text "Read more..." ]
        ]


viewBanner =
    div [ class "banner" ]
        [ div [ class "container" ]
            [ h1 [ class "logo-font" ] [ text "conduit" ]
            , p [] [ text "A place to share your knowledge." ]
            ]
        ]


viewTag selectedTagName tagName =
    let
        otherClass =
            if tagName == selectedTagName then
                "tag-selected"

            else
                "tag-default"
    in
    button
        [ class ("tag-pill " ++ otherClass)
        , onClick { description = "ClickedTag", data = tagName }]
        [ text tagName ]


viewTags model =
    div [ class "tag-list" ] (List.map (viewTag model.selectedTag) model.tags)



-- MAIN


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
