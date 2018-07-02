library(rvest)
library(dplyr)

state_fxr <- function(x){
        paste0(",_", gsub(" ", "_", x))
}

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

html_chkr <- function(x){
        class(try(read_html(x), silent=TRUE))[1]
}

wiki_link_chkr <- function(x, area_name){
        link1 <- paste0(x[1], area_name, x[2], 
                        x[3])
        
        if(html_chkr(link1) == "try-error"){
                link <- paste0(x[1], area_name, x[3])
        } else {
                link <- link1
        }
        closeAllConnections()
        return(link)
}

node_ckr <- function(wikihtml, path){
        class(try(html_nodes(wikihtml, css = path),silent=TRUE))[1]
}

wiki_node_ckr <- function(wikihtml, path){
        if(node_ckr(wikihtml, path)=="try-error"){
                try(stop(simpleError("wrong table number"))) 
        } else {
                for_table <- html_nodes(wikihtml, css = path)
                return(for_table)
        }
}

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

towns_grabber <- function(county, state){
        tag <- "div.column-count-4"
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



