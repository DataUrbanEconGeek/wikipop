#' A function to fix the state's name for wikipedia link

state_fxr <- function(x){
        paste0(",_", gsub(" ", "_", x))
}