#' A function to check link

html_chkr <- function(x){
        class(try(read_html(x), silent=TRUE))[1]
}