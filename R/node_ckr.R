#' A function to check css node
#' @export node_ckr

node_ckr <- function(wikihtml, path){
        class(try(rvest::html_nodes(wikihtml, css = path),silent=TRUE))[1]
}
