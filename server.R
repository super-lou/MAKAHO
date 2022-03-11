


server = function (input, output, session) {

    ### Map
    observeEvent(input$map_button, {
        toggle(id='map_panel')
    })

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

    observeEvent(input$theme_choice, {
        map = leafletProxy("map")
        map = clearShapes(map)
        label =
            paste0(
                "<b>lat. </b>", signif(df_meta()$lat, 6),
                " / <b>lon. </b>", signif(df_meta()$lon, 6), '<br>',
                "<b>code </b>", df_meta()$code, '<br>',
                "<b>nom </b>", df_meta()$nom, '<br>'
                )
        
        map = addCircleMarkers(map,
                               lng=df_meta()$lon,
                               lat=df_meta()$lat,
                               radius=5, weight=1,
                               color='grey50', fillColor='grey80',
                               opacity=1, fillOpacity=1,
                               label=lapply(label, HTML))
    })
    
    
    ### Analyse
    observeEvent(input$ana_button, {
        toggle(id='ana_panel')
    })

    observe({
        toggle(id="proba_choice",
               condition=input$var %in% varP)

        if (input$var %in% varP) {
            choices = valP[[which(input$var == varP)]]
        } else {
            choices = FALSE
        }
        updateRadioButtons(session, "proba_choice",
                           label=word("varp"),
                           inline=TRUE,
                           choices=choices)
    })

    df_XEx = reactive({
        monthStart = formatC(input$anHydro_input,
                             width=2, flag=0)
        filename = paste0('data_',
                          input$var, '_',
                          monthStart, '.fst')
        df_dataExtmp = read_FST(computer_data_path,
                             filename,
                             filedir='fst')
        names(df_dataExtmp)=c('datetime', 'group1', 'values', 'code')
        df_dataExtmp
    })
        
    df_meta = reactive({
        df_metatmp = read_FST(computer_data_path, 'meta.fst',
                              filedir='fst')
        crs_rgf93 = st_crs(2154)
        crs_wgs84 = st_crs(4326)
        sf_loca = st_as_sf(df_metatmp[c("L93X_m_BH", "L93Y_m_BH")],
                           coords=c("L93X_m_BH", "L93Y_m_BH"))
        st_crs(sf_loca) = crs_rgf93
        sf_loca = st_transform(sf_loca, crs_wgs84)
        sf_loca = st_coordinates(sf_loca$geometry)
        df_metatmp$lon = sf_loca[, 1]
        df_metatmp$lat = sf_loca[, 2]
        df_metatmp
    })
    
    period = reactive({
        monthStart = formatC(input$anHydro_input,
                             width=2, flag=0)
        monthEnd = formatC((input$anHydro_input-2)%%12+1,
                           width=2, flag=0)
        paste0(input$dateStart_input, "-",
               monthStart, "-01 / ",
               input$dateEnd_input, "-",
               monthEnd, "-31")
    })

    
    df_Xtrend = Estimate.stats(data.extract=df_dataEx(),
                               dep.option='AR1')
    

    ### Search
    observeEvent(input$search_button, {
        toggle(id='search_panel')
    })

    observe({
        updateSelectizeInput(session, 'search_input',
                             choices=df_meta()$code,
                             server=TRUE)
    })

    
   
} 






# observe({
#     month_start = formatC(input$anHydro_sli, width=2, flag=0)
#     month_end = formatC((input$anHydro_sli-2)%%12+1, width=2, flag=0)

#     updateDateRangeInput(session, "dateAnalyse_inp",
#                          start=paste0("1968-", month_start, '-01'),
#                          end=paste0("2020-", month_end, '-31'))

#     updateTextInput(session, "dateStart_inp",
#                     value=paste("New text", value))

# })

