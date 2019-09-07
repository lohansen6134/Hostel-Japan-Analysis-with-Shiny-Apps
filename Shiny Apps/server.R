function(input, output){
   
    output$hostel1 <- renderPlotly({
        h.price <- hostel %>% 
            filter(City == input$City) %>% 
            group_by(price.from) %>% 
            summarise(hostel.price = n()) %>% 
            ungroup() %>% 
            gather(key, value, -price.from) %>% 
            mutate(text = paste("<br>","price", ":",price.from,",", "total", ":", value))
        
        h.price.pl <- ggplot(h.price, aes(x = value, y = price.from, text = text))+
            geom_jitter(aes(col = price.from))+
            theme(legend.position = "none")+
            theme_bw()+
            labs(x = NULL,
                 y = NULL,
                 title = "Hostel Starting Price each City")
        
        ggplotly(h.price.pl, tooltip = "text")
    })
    
    output$hostel2 <- renderPlotly({
        h.rating <- hostel %>% 
            filter(City == input$City1) %>% 
            group_by(rating.band) %>%
            summarise(rating = n()) %>% 
            ungroup() %>% 
            gather(key, value, -rating.band) %>% 
            mutate(text = paste(rating.band, ":", value))
        
        h.rating.pl <- ggplot(h.rating, aes(x = value, y = rating.band, text = text))+
            geom_jitter(aes(size = value, col = value))+
            theme(legend.position = "none")+
            theme_bw()+
            labs(x = NULL,
                 y = NULL,
                 title = "Hostel Rating each City")
        
        ggplotly(h.rating.pl, tooltip = "text")
    })
 
    output$hostel3 <- renderPlotly({
        h.score <- hostel %>% 
            select(City, rating.band, summary.score, valueformoney) %>% 
            filter(rating.band == input$rating.band1) %>% 
            group_by(City) %>% 
            summarise(summary.score = round(mean(summary.score),2),
                      value.for.money = round(mean(valueformoney),2)) %>% 
            ungroup() %>% 
            gather(key, value, - City) %>% 
            mutate(text = paste(key, ":", value))
        
        h.score.pl <- ggplot(h.score, aes(x = City, y = value, text=text))+
            geom_col(aes(fill = key), position = "dodge") + coord_flip()+
            theme(legend.position = "bottom")+ 
            theme_bw()+
            labs(x = NULL,
                 y = NULL,
                 title = "Summary Score vs Value For Money")
        
        ggplotly(h.score.pl, tooltip = "text")
    })
    
    output$hostel4 <- renderLeaflet({
        h.rb <- hostel %>% 
            filter(rating.band == input$rating.band2)
        
        leaflet(data = h.rb) %>% 
            addTiles() %>% 
            addCircles(lng = ~lon,
                       lat = ~lat,
                       weight = 5,
                       radius = ~sqrt(summary.score) * 30,
                       popup = ~City,
                       fillColor = "transparent",
                       highlightOptions = highlightOptions(weight = 10,
                                                           color = "brown",
                                                           fillColor = "green"),
                       label = ~hostel.name)
    })
    
    output$infobox1 <- renderInfoBox({
        h.price <- hostel %>% 
            filter(City == input$City) %>% 
            group_by(price.from) %>% 
            summarise(hostel.price = n()) %>% 
            ungroup() %>% 
            gather(key, value, -price.from) %>% 
            mutate(text = paste("<br>","price", ":",price.from,",", "total", ":", value))
        
        infoBox(title = "Lowest Price", value = h.price$price.from[1],icon = icon('dollar'))
    })
    
    output$infobox2 <- renderInfoBox({
        infoBox(value = filter(hostel, City == input$City) %>% select(hostel.name), title = 'Hostel Name', icon = icon("city"))
    })
}
