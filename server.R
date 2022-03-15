


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

    observeEvent({ ### /!\
        input$theme_choice
        input$signif_choice
        df_meta()
        fillList()
    }, {
        map = leafletProxy("map")
        
        alpha = as.numeric(sub("%", "", input$signif_choice)) / 100


        Code = rle(df_meta()$code)$values

        OkS = df_trend()$p <= alpha
        CodeSU = df_trend()$code[OkS & df_trend()$trend >= 0]
        CodeSD = df_trend()$code[OkS & df_trend()$trend < 0]
        CodeNS = df_trend()$code[!OkS]
        
        shapeList = rep(1, length(fillList()))
        shapeList[Code %in% CodeSU] = '^'
        shapeList[Code %in% CodeSD] = 'v'
        shapeList[Code %in% CodeNS] = 'o'

        markerList = get_markerList(shapeList, fillList(),
                                    resources_path)

        print(markerList)
        
        label =
            paste0(
                "<b>", word('m.hov.lat'),". </b>",
                    signif(df_meta()$lat, 6),
                " / <b>", word('m.hov.lon'),". </b>",
                    signif(df_meta()$lon, 6), '<br>',
                "<b>", word('m.hov.code')," </b>",
                    df_meta()$code, '<br>',
                "<b>", word('m.hov.name')," </b>",
                    df_meta()$nom, '<br>'
            )

        map = clearMarkers(map)
        map = addMarkers(map,
                         lng=df_meta()$lon,
                         lat=df_meta()$lat,
                         icon=markerList,
                         label=lapply(label, HTML))
        map = addCircleMarkers(map,
                               lng=df_meta()$lon,
                               lat=df_meta()$lat,
                               radius=3,
                               fillColor=Cgreymid, fillOpacity=1,
                               color=Cgreymid, opacity=1)

    })
    
    
    ### Analyse
    observeEvent(input$ana_button, {
        toggle(id='ana_panel')
    })

    period = reactive({
        monthStart = formatC(input$anHydro_input,
                             width=2, flag=0)
        monthEnd = formatC((input$anHydro_input-2)%%12+1,
                           width=2, flag=0)

        DateStart = as.Date(paste(input$dateStart_input,
                                  monthStart,
                                  '01',
                                  sep='-'))
        DateEnd = as.Date(paste(input$dateEnd_input,
                                monthStart,
                                '01',
                                sep='-')) - 1
        
        paste0(DateStart, " / ", DateEnd)
    })

    output$period = renderText({
        period()
    })

    var = reactive({
        varVect[varNameVect == input$varName]
    })

    observe({
        toggle(id="proba_choice",
               condition=var() %in% varP)

        if (var() %in% varP) {
            choices = valP[[which(var() == varP)]]
        } else {
            choices = FALSE
        }
        updateRadioButtons(session, "proba_choice",
                           label=word("varP"),
                           inline=TRUE,
                           choices=choices)
    })

    filename = reactive({ 
        monthStart = formatC(input$anHydro_input,
                             width=2, flag=0)
        filenametmp = paste0(var(), 'Ex_',
                             monthStart, '.fst')

        file_path = file.path(computer_data_path, 'fst', filenametmp)
        if (file.exists(file_path)) {
            filenametmp
        } else {
            NULL
        }
    })
    
    df_XEx = reactive({
        if (!is.null(filename())) {
            df_XExtmp = read_FST(computer_data_path,
                                 filename(),
                                 filedir='fst')
            names(df_XExtmp)=c('datetime', 'group1', 'values', 'code')

            Start = as.Date(substr(period(), 1, 10))
            End = as.Date(substr(period(), 14, 23))
            Date = as.Date(df_XExtmp$datetime) ### /!\
            
            df_XExtmp = df_XExtmp[Date >= Start & Date <= End,]
            df_XExtmp
        } else {
            NULL
         }
    })
        
    df_meta = reactive({
        df_metatmp = read_FST(computer_data_path,
                              'meta.fst',
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
    
    df_trend = reactive({
        if (!is.null(df_XEx())) {
            Estimate.stats(data.extract=df_XEx(),
                           dep.option='AR1')
        } else {
            NULL
        }
    })

    fillList = reactive({
        Code = rle(df_meta()$code)$values
        nCode = length(Code)
        
        if (!is.null(df_XEx()) | !is.null(df_trend())) {            
            res = get_trendExtremes(df_XEx(), df_trend(), df_meta(),
                                    toMean=TRUE)
            TrendValueList = res$value
            minTrendValue = res$min
            maxTrendValue = res$max

            fillListtmp = c()
            for (k in 1:nCode) {

                trendValue = TrendValueList[k]

                color = get_color(trendValue, 
                                  minTrendValue,
                                  maxTrendValue,
                                  palette_name='perso',
                                  reverse=TRUE)
                
                fillListtmp = c(fillListtmp, color)
            }
            fillListtmp
        } else {
            rep('grey50', nCode)
        }
    })
    
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

