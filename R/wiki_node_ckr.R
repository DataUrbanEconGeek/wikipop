#' A function to the wikipedia node
#' @include node_ckr.R
#' @import rvest
#' @export
wiki_node_ckr <- function(wikihtml, path){
        if(node_ckr(wikihtml, path)=="try-error"){
                try(stop(simpleError("wrong table number")))
        } else {
                for_table <- html_nodes(wikihtml, css = path)
                return(for_table)
        }
}
