#' A function to check link
#' @export html_chkr

html_chkr <- function(x){
        class(try(rvest::read_html(x), silent=TRUE))[1]
}
