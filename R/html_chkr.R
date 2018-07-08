#' A function to check link
#' @import rvest
#' @export
html_chkr <- function(x){
        class(try(read_html(x), silent=TRUE))[1]
}
