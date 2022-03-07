library(shiny)
library(leaflet)


server = function (input, output, session) {

    urlTile = reactive({
        get_urlTile(input$theme_choice,
                    provider,
                    theme_file,
                    resources_path)
    })
    
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
                       urlTemplate=urlTile())
    })

    observeEvent(input$ana_button, {
        toggle(id='ana_panel')
    })

    observeEvent(input$map_button, {
        toggle(id='map_panel')
    })
    
    observeEvent(input$search_button, {
        toggle(id='search_panel')
    })


    # observe({
    #     toggle(id="action",
    #            condition=input$var %in% varP)
    # })
    

    # observe({
    #     month_start = formatC(input$anHydro_sli, width=2, flag=0)
    #     month_end = formatC((input$anHydro_sli-2)%%12+1, width=2, flag=0)
        
    #     updateDateRangeInput(session, "dateAnalyse_inp",
    #                          start=paste0("1968-", month_start, '-01'),
    #                          end=paste0("2020-", month_end, '-31'))
        
    #     updateTextInput(session, "dateStart_inp",
    #                     value=paste("New text", value))
        
    # })

    
    period = reactive({
        create_period(input$anHydro_input,
                      input$dateStart_input,
                      input$dateEnd_input)
    })

    output$period <- renderText({
        period()
    })


    observe({
        print(input$search_input)
    })
   
} 
