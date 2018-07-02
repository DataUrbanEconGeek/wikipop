#' A function to check css node

node_ckr <- function(wikihtml, path){
        class(try(html_nodes(wikihtml, css = path),silent=TRUE))[1]
}