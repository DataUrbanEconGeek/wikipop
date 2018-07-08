#' A function to assemble and check the wikipedia link
#' @include html_chkr.R
#' @export
wiki_link_chkr <- function(x, area_name){
        link1 <- paste0(x[1], area_name, x[2],
                        x[3])

        if(html_chkr(link1) == "try-error"){
                link <- paste0(x[1], area_name, x[3])
        } else {
                link <- link1
        }
        closeAllConnections()
        return(link)
}
