#' A function to scrape the list of towns displayed on wikipedia page for a
#' county.
#' @include state_fxr.R
#' @import rvest
#' @export
towns_grabber <- function(county, state){
        tag <- "div.column-width"
        state_fixed <- state_fxr(state)
        county_fixd <- paste0(county, "_County")
        link <- paste0("https://en.wikipedia.org/wiki/", county_fixd,
                       state_fixed)
        towns <- read_html(link) %>%
                html_nodes(css = tag) %>%
                html_text()
        towns_list <- strsplit(towns, '\n')
        town_unlist <- unlist(towns_list)
        town_vect <- town_unlist[-1]
        return(town_vect)
}
