#' A function to to make the components of a wikipedia link
#' @include state_fxr.R
#' @export
wiki_link_comp <- function(type, state){
        types <- c("_County", "_(town)", "_(village)", "")
        state_fix <- state_fxr(state)

        if(type == "county"){
                tp <- types[1]
        } else if(type == "town"){
                tp <- types[2]
        } else if(type == "village") {
                tp <- types[3]
        } else if(type == "city") {
                tp <- types[4]
        } else {
                tp <- NULL
                try(stop(simpleError("Not valid area type")))
        }

        wiki_link_text <- c("https://en.wikipedia.org/wiki/", tp,
                            state_fix)

        return(wiki_link_text)
}
