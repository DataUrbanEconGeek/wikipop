#' A function to the wikipedia node
#' @include node_ckr.R
#' @export wiki_node_ckr

wiki_node_ckr <- function(wikihtml, path){
        if(node_ckr(wikihtml, path)=="try-error"){
                try(stop(simpleError("wrong table number")))
        } else {
                for_table <- rvest::html_nodes(wikihtml, css = path)
                return(for_table)
        }
}
