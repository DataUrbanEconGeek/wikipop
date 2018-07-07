#' Prepare state's name for wikipedia link
#'
#' @param x A character string of a state's name
#' @export state_fxr
#' @examples
#' state_fxr("New York")

state_fxr <- function(x){
        paste0(",_", gsub(" ", "_", x))
}
