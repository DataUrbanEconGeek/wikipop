#' A function to scrape the historic population data from wikipedia.
#' The function returns a dataframe.

area_populations <- function(area_name, state, type = "county"){
        wiki_link_text <- try(wiki_link_comp(type = type, state))
        
        full_link <- wiki_link_chkr(wiki_link_text, area_name)
        wikihtml <- try(read_html(full_link))
        
        path <- "table.toccolours"
        
        if(class(wikihtml)[1] == "try-error"){
                try(stop(""))
        } else {
                population <- wiki_node_ckr(wikihtml, path) %>%
                        html_table()
                if(length(population[[1]]) == 3){
                        df <- cbind(population[[1]][1], population[[1]][2], 
                                    population[[1]][3])
                } else if(length(population[[1]]) == 4){
                        df <- cbind(population[[1]][1], population[[1]][2], 
                                    population[[1]][4])
                } else {
                        try(stop("wrong table number")) 
                }
                names(df) <- c("census_year", "population", 
                               "percent_change")
                df <- df[3:length(df$population)-1,]
                
                pop_fix <- c()
                for(i in 1:length(df$population)){
                        fixed <- gsub(",", "", 
                                      as.character(df$population[i]))
                        pop_fix <- append(pop_fix, fixed)
                }
                df$population <- as.numeric(pop_fix)
                
                closeAllConnections()
                return(df)
        }
}
