


server = function (input, output, session) {
    session$onSessionEnded(stopApp)    
    
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

        CodeSample = rv$CodeSample
        nCodeSample = length(CodeSample)

        
        OkS = df_trend()$p <= alpha
        CodeSU = df_trend()$code[OkS & df_trend()$trend >= 0]
        CodeSD = df_trend()$code[OkS & df_trend()$trend < 0]
        CodeNS = df_trend()$code[!OkS]
        
        shapeList = rep(1, length(fillList()))
        shapeList[match(CodeSU, CodeAll())] = '^'
        shapeList[match(CodeSD, CodeAll())] = 'v'
        shapeList[match(CodeNS, CodeAll())] = 'o'

        markerListAll = get_markerList(shapeList,
                                       fillList(),
                                       resources_path)

        okCode = unlist(markerListAll$iconUrl) != rv$iconUrl_save
        Code = CodeAll()[okCode]
        markerList = markerListAll
        markerList$iconUrl = markerListAll$iconUrl[okCode]
        Lon = df_meta()$lon[okCode]
        Lat = df_meta()$lat[okCode]
        Nom = df_meta()$nom[okCode]
        
        label =
            paste0(
                "<b>", word('m.hov.lat'),". </b>",
                signif(Lat, 6),
                " / <b>", word('m.hov.lon'),". </b>",
                signif(Lon, 6), '<br>',
                "<b>", word('m.hov.code')," </b>",
                Code, '<br>',
                "<b>", word('m.hov.name')," </b>",
                Nom, '<br>'
            )
        
        map = removeMarker(map, layerId=Code)
        map = addMarkers(map,
                         lng=Lon,
                         lat=Lat,
                         icon=markerList,
                         label=lapply(label, HTML),
                         layerId=Code)
        
        rv$iconUrl_save = unlist(markerListAll$iconUrl)
    })    
    
    ### Analyse
    observeEvent(input$ana_button, {
        toggle(id='ana_panel')
    })

    period = reactive({
        monthStart = formatC(input$dateMonth_slider,
                             width=2, flag=0)
        monthEnd = formatC((input$dateMonth_slider-2)%%12+1,
                           width=2, flag=0)

        DateStart = as.Date(paste(input$dateYear_slider[1],
                                  monthStart,
                                  '01',
                                  sep='-'))
        DateEnd = as.Date(paste(input$dateYear_slider[2],
                                monthStart,
                                '01',
                                sep='-')) - 1
        
        paste0(DateStart, " / ", DateEnd)
    })
    period = debounce(period, 1000)
    

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
        monthStart = substr(period(), 6, 7)
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
        df_metatmp = df_metatmp[order(df_metatmp$code),]
        df_metatmp
    })

    
    CodeAll = reactive({
        rle(df_meta()$code)$values
    })
        
    rv = reactiveValues(CodeSample=isolate(CodeAll()),
                        markerList_save=NULL)
    
    observeEvent(input$map_marker_click, {
        codeClick = input$map_marker_click$id
        CodeSample = rv$CodeSample
        if (codeClick %in% CodeSample) {
            newCodeSample = CodeSample[CodeSample != codeClick]
        } else {
            newCodeSample = c(CodeSample, codeClick)
        }
        rv$CodeSample = newCodeSample
    })
    
    observeEvent(input$code_picker, {
        rv$CodeSample = input$code_picker
    })

    observe({
        updatePickerInput(session, "code_picker",
                          choices=CodeAll(),
                          selected=rv$CodeSample)
        if (!is.null(input$code_picker)) {
            codeNULL_obs$resume()
        }
    })

    codeNULL_obs = observe({
        if (is.null(input$code_picker)) {
            rv$CodeSample = input$code_picker
            print('null')
        }
    }, suspended=TRUE)
    

    df_trend = reactive({
        if (!is.null(df_XEx())) {
            Estimate.stats(data.extract=df_XEx(),
                           dep.option='AR1')
        } else {
            NULL
        }
    })

    fillList = reactive({
        CodeSample = rv$CodeSample
        nCodeAll = length(CodeAll())
        
        if (!is.null(df_XEx()) | !is.null(df_trend())) {            
            res = get_trendExtremes(df_XEx(), df_trend(),
                                    CodeAll=CodeAll(),
                                    CodeSample=CodeSample,
                                    toMean=TRUE)
            TrendValues = res$values
            minTrendValue = res$min
            maxTrendValue = res$max

            fillListtmp = c()
            for (k in 1:nCodeAll) {

                code = CodeAll()[k]
                
                if (code %in% CodeSample) {
                    trendValue = TrendValues[k]

                    color = get_color(trendValue, 
                                      minTrendValue,
                                      maxTrendValue,
                                      palette_name='perso',
                                      reverse=TRUE)
                } else {
                    color = grey94COL
                }
                
                fillListtmp = c(fillListtmp, color)
            }
            fillListtmp
        } else {
            rep(grey50COL, nCodeAll)
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

