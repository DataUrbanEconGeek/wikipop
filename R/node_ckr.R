#' A function to check css node
#' @import rvest
#' @export
node_ckr <- function(wikihtml, path){
        class(try(html_nodes(wikihtml, css = path),silent=TRUE))[1]
}
