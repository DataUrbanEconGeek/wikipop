#' A function to scrape the list of villages displayed on wikipedia page for a
#' county.
#' @include state_fxr.R
#' @export village_grabber

village_grabber <- function(county, state){
        tag <- "div.column-count-4~ .column-count-2"
        state_fixed <- state_fxr(state)
        county_fixd <- paste0(county, "_County")
        link <- paste0("https://en.wikipedia.org/wiki/", county_fixd,
                       state_fixed)
        villages <- rvest::read_html(link) %>%
                rvest::html_nodes(css = tag) %>%
                rvest::html_text()
        village_list <- strsplit(villages, '\n')
        village_unlist <- unlist(village_list)
        village_vect <- village_unlist[-1]
        return(village_vect)
}



