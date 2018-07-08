#' Prepare state's name for wikipedia link
#'
#' @param x A character string of a state's name
#' @examples
#' state_fxr("New York")
#' @export
state_fxr <- function(x){
        paste0(",_", gsub(" ", "_", x))
}
