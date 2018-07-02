#' A function to scrape the list of villages displayed on wikipedia page for a 
#' county. 


village_grabber <- function(county, state){
        tag <- "div.column-count-4~ .column-count-2"
        state_fixed <- state_fxr(state)
        county_fixd <- paste0(county, "_County")
        link <- paste0("https://en.wikipedia.org/wiki/", county_fixd, 
                       state_fixed)
        villages <- read_html(link) %>%
                html_nodes(css = tag) %>%
                html_text()
        village_list <- strsplit(villages, '\n')
        village_unlist <- unlist(village_list)
        village_vect <- village_unlist[-1]
        return(village_vect)
}



