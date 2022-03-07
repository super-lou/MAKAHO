library(shiny)
library(leaflet)

minZoom = 1
maxZoom = 13


server = function (input, output, session) {

    output$map = renderLeaflet({
        map = leaflet(options=leafletOptions(minZoom=minZoom,
                                             maxZoom=maxZoom,
                                             worldCopyJump=FALSE,
                                             zoomControl=FALSE))
        map = setView(map,
                      centroids$longitude[centroids$country == country],
                      centroids$latitude[centroids$country == country],
                      6)
        
        map = addTiles(map,
                       urlTemplate=urlTile)
    })

    observeEvent(input$Menu_button, {
        toggle('Menu')
    })

    output$var = renderText({
        paste("You chose", input$var)
    })


} 
