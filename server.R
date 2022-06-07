# \\\
# Copyright 2022 Louis Héraut*1
#
# *1   INRAE, France
#      louis.heraut@inrae.fr
#      https://github.com/super-lou
#
# This file is part of sht R toolbox.
#
# Sht R toolbox is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Sht R toolbox is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with sht R toolbox.
# If not, see <https://www.gnu.org/licenses/>.
# ///
#
#
# server.R


server = function (input, output, session) {
    session$onSessionEnded(stopApp)    


    rv = reactiveValues(width=0,
                        height=0,
                        CodeSample=NULL,
                        CodeSearch=NULL,
                        markerListAll_save=NULL,
                        CodeSample_save=NULL,
                        Search_save=NULL,
                        polyCoord=NULL,
                        theme_choice_save=NULL,
                        mapHTML=NULL,
                        polyMode='false',
                        clickMode=FALSE,
                        downloadMode=FALSE,
                        inputPhoto=FALSE,
                        currentLimits=NULL,
                        map_bounds=NULL, 
                        mapPreview_bounds=NULL,
                        defaultBounds=NULL,
                        TrendValues=NULL,
                        minTrendValue=NULL,
                        maxTrendValue=NULL
                        )
    
## 1. MAP ____________________________________________________________
    observeEvent(input$theme_button, {
        toggle(id='theme_panel')
        hide(id='ana_panel')
        hide(id='info_panel')
    })

### 1.1. Background __________________________________________________
    urlTile = reactive({
        get_urlTile(input$theme_choice,
                    provider,
                    theme_file,
                    resources_path,
                    token=jawg_token)
    })

    defaultLimits = reactive({
        Lon = df_meta()$lon
        Lat = df_meta()$lat
        list(north=max(Lat), east=max(Lon),
             south=min(Lat), west=min(Lon))
    })
    
    output$map = renderLeaflet({
        map = leaflet(options=leafletOptions(minZoom=minZoom,
                                             maxZoom=maxZoom,
                                             zoomControl=FALSE,
                                             attributionControl=FALSE))
        map = fitBounds(map,
                        lng1=defaultLimits()$east,
                        lat1=defaultLimits()$south,
                        lng2=defaultLimits()$west,
                        lat2=defaultLimits()$north,
                        options=list(padding=c(20, 20)))
        
        map = addTiles(map, urlTemplate=urlTile())
        map = addEasyprint(map, options=easyprintOptions(
                                    exportOnly=TRUE,
                                    hideControlContainer=TRUE,
                                    hidden=TRUE))
        
        rv$mapHTML = map
    })
    
    output$mapPreview = renderLeaflet({
        mapPreview = leaflet(options=leafletOptions(
                                 zoomControl=FALSE,
                                 attributionControl=FALSE))
        mapPreview = fitBounds(mapPreview,
                               lng1=defaultLimits()$east,
                               lat1=defaultLimits()$south,
                               lng2=defaultLimits()$west,
                               lat2=defaultLimits()$north,
                               options=list(padding=c(20, 20)))
    })

    


### 1.2. Zoom ________________________________________________________    
    observeEvent({
        input$dimension
    }, {
        map = leafletProxy("map")
        map = fitBounds(map,
                        lng1=defaultLimits()$east,
                        lat1=defaultLimits()$south,
                        lng2=defaultLimits()$west,
                        lat2=defaultLimits()$north,
                        options=list(padding=c(20, 20)))
    })

    observeEvent({
        CodeSample()
        df_meta()
    }, {
        if (!is.null(CodeSample())) {
            Lon = df_meta()$lon[df_meta()$code %in% CodeSample()]
            Lat = df_meta()$lat[df_meta()$code %in% CodeSample()]
            rv$currentLimits = list(north=max(Lat), east=max(Lon),
                                    south=min(Lat), west=min(Lon))

            if (length(CodeSample()) > 1) {
                mapPreview = leafletProxy("mapPreview")
                mapPreview = fitBounds(mapPreview,
                                       lng1=rv$currentLimits$east,
                                       lat1=rv$currentLimits$south,
                                       lng2=rv$currentLimits$west,
                                       lat2=rv$currentLimits$north,
                                       options=list(padding=c(20, 20)))
            } else {
                rv$mapPreview_bounds = NULL
            }
        } else {
            rv$currentLimits = NULL
            rv$mapPreview_bounds = NULL
        }        
    })

    observeEvent({
        input$mapPreview_bounds
    }, {
        rv$mapPreview_bounds = input$mapPreview_bounds
    })
    
    observeEvent(input$focusZoom_button, {
        map = leafletProxy("map")
        map = fitBounds(map,
                        lng1=rv$currentLimits$east,
                        lat1=rv$currentLimits$south,
                        lng2=rv$currentLimits$west,
                        lat2=rv$currentLimits$north,
                        options=list(padding=c(20, 20)))
    })
    
    observeEvent(input$defaultZoom_button, {
        map = leafletProxy("map")
        map = fitBounds(map,
                        lng1=defaultLimits()$east,
                        lat1=defaultLimits()$south,
                        lng2=defaultLimits()$west,
                        lat2=defaultLimits()$north,
                        options=list(padding=c(20, 20)))
    })
    
    observeEvent({
        input$map_bounds
        rv$mapPreview_bounds
    }, {

        windowChange = input$dimension[1] != rv$width | input$dimension[2] != rv$height
        if (windowChange) {
            rv$defaultBounds = input$map_bounds
            rv$width = input$dimension[1]
            rv$height = input$dimension[2]
        }

        print('ok')
        print(rv$defaultBounds)

        error = 0.1
        
        isDefault = all(abs(unlist(input$map_bounds) - unlist(rv$defaultBounds)) <= error)
        
        isFocus = all(abs(unlist(input$map_bounds) - unlist(rv$mapPreview_bounds)) <= error)

        if (windowChange) {
            isDefault = TRUE
            isFocus = TRUE
        }
        
        if (isDefault & isFocus) {
            hide(id='focusZoom_panel')
            hide(id='defaultZoom_panel')
            
        } else if (isDefault & !isFocus) {
            showElement(id='focusZoom_panel')
            hide(id='defaultZoom_panel')
            
        } else if (!isDefault & isFocus) {
            hide(id='focusZoom_panel')
            showElement(id='defaultZoom_panel')
            
        } else if (!isDefault & !isFocus) {
            showElement(id='focusZoom_panel')
            hide(id='defaultZoom_panel')
        }
    })

### 1.3. Marker ______________________________________________________
    observeEvent({
        input$theme_choice
        input$alpha_choice
        df_meta()
        fillList()
    }, {
        map = leafletProxy("map")
        
        alpha = as.numeric(sub("%", "", input$alpha_choice)) / 100
        
        OkS = df_Xtrend()$p <= alpha
        CodeSU = df_Xtrend()$code[OkS & df_Xtrend()$trend >= 0]
        CodeSD = df_Xtrend()$code[OkS & df_Xtrend()$trend < 0]
        CodeNS = df_Xtrend()$code[!OkS]

        shapeList = rep(1, length(fillList()))
        shapeList[match(CodeSU, CodeAll())] = '^'
        shapeList[match(CodeSD, CodeAll())] = 'v'
        shapeList[match(CodeNS, CodeAll())] = 'o'

        markerListAll = get_markerList(shapeList,
                                       fillList(),
                                       resources_path)

        if (input$theme_choice != rv$theme_choice_save | is.null(unlist(rv$markerListAll_save$iconUrl))) {
            okCode = rep(TRUE, length(CodeAll()))
        } else {
            okCode = unlist(markerListAll$iconUrl) != unlist(rv$markerListAll_save$iconUrl)
        }
        rv$theme_choice_save = input$theme_choice

        Code = CodeAll()[okCode]
        markerList = markerListAll
        markerList$iconUrl = markerListAll$iconUrl[okCode]
        Lon = df_meta()$lon[okCode]
        Lat = df_meta()$lat[okCode]
        Nom = df_meta()$nom[okCode]
        
        label = get_label(Lon, Lat, Code, Nom)

        map = removeMarker(map, layerId=Code)
        map = addMarkers(map,
                         lng=Lon,
                         lat=Lat,
                         icon=markerList,
                         label=lapply(label, HTML),
                         layerId=Code)

        rv$markerListAll_save = markerListAll
    })    
    

## 2. ANALYSE ________________________________________________________
    observeEvent(input$ana_button, {
        toggle(id='ana_panel')
        hide(id='theme_panel')
        hide(id='info_panel')
    })

### 2.1. Period ______________________________________________________
    period = reactive({
        month = which(Months == input$dateMonth_slider)
        monthStart = formatC(month, width=2, flag=0)
        monthEnd = formatC((month-2)%%12+1, width=2, flag=0)

        Start = as.Date(paste(input$dateYear_slider[1],
                              monthStart,
                              '01',
                              sep='-'))
        End = as.Date(paste(input$dateYear_slider[2],
                            monthStart,
                            '01',
                            sep='-')) - 1
        c(Start, End)
    })
    period = debounce(period, 1000)

    output$period = renderText({
        start = format(period()[1], "%d-%m-%Y")
        end = format(period()[2], "%d-%m-%Y")
        paste0('Du ', start, ' au ', end)
    })

### 2.2. Variable extration __________________________________________
    observeEvent(input$event_choice, {
        var_event = Var$var[Var$event == input$event_choice]        
        updateRadioGroupButtons(session, "var_choice",
                                status="RadioButton",
                                choices=var_event,
                                selected=var_event[1])
    })

    var = reactive({
        if (is.null(input$var_choice)) {
            Var$var[1]
        } else {
            input$var_choice
        }
    })

    name = reactive({
        Var$name[Var$var == var()]
    })

    type = reactive({
        Var$type[Var$var == var()]            
    })

    proba = reactive({
        id = which(Var$var == var())
        if (!identical(id, integer(0))) {
            Var$proba[[id]]
        } else {
            NULL
        }
    })

    output$data = renderText({
        data = paste0(var(), ' : ', name())
        if (!is.null(proba())) {
            data = paste0(data, ' avec la probabilité de ',
                          input$proba_choice)
        }
        data
    })

    observe({
        toggle(id="proba_row",
               condition=!is.null(proba()))

        if (!is.null(proba())) {
            choices = proba()
        } else {
            choices = FALSE
        }
        updateRadioGroupButtons(session, "proba_choice",
                                status="RadioButton",
                                choices=choices)
    })

    filename = reactive({
        monthStart = substr(period()[1], 6, 7)
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

            Start = period()[1]
            End = period()[2]
            
            df_XExtmp = df_XExtmp[df_XExtmp$Date >= Start
                                  & df_XExtmp$Date <= End,]
            df_XExtmp
        } else {
            NULL
         }
    })

### 2.3. Station metadata ____________________________________________
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

### 2.4. Station selection ___________________________________________
    CodeAll = reactive({
        rle(df_meta()$code)$values
    })

    rv$CodeSample = isolate(CodeAll())
    rv$CodeSample_save = isolate(CodeAll())
    rv$theme_choice_save = isolate(input$theme_choice)
    
    CodeSample = reactive({
        if (identical(rv$CodeSample, character(0))) {
            NULL
        } else {
            rv$CodeSample
        }
    })
    CodeSample = debounce(CodeSample, 500)

#### 2.4.1. All/none _________________________________________________
    observeEvent(input$all_button, {
        rv$CodeSample = CodeAll()
    })

    observeEvent(input$none_button, {
        updateSelectizeInput(session, 'search_input',
                             selected="")
        rv$CodeSample = NULL
    })
    
#### 2.4.2. Map click ________________________________________________
    observeEvent(input$click_button, {
        hide(id='ana_panel')
        hide(id='theme_panel')
        hide(id='info_panel')
        hide(id='poly_panel')
        hide(id='download_panel')
        showElement(id='click_panel')
        rv$clickMode = TRUE
    })

    observeEvent(input$map_marker_click, {
        if (rv$polyMode == 'false' & rv$clickMode & !rv$downloadMode) {
            codeClick = input$map_marker_click$id
            CodeSample = rv$CodeSample
            if (codeClick %in% CodeSample) {
                newCodeSample = CodeSample[CodeSample != codeClick]
            } else {
                newCodeSample = c(CodeSample, codeClick)
            }
            rv$CodeSample = newCodeSample
        }
    })

    observeEvent(input$clickOk_button, {
        rv$clickMode = FALSE
        hide(id='click_panel')
        showElement(id='ana_panel')
    })

#### 2.4.3. Polygone _________________________________________________
    observeEvent(input$poly_button, {
        hide(id='ana_panel')
        hide(id='theme_panel')
        hide(id='info_panel')
        hide(id='click_panel')
        hide(id='download_panel')
        showElement(id='poly_panel')
        rv$polyMode = "Add"
        rv$polyCoord = tibble()
    })

    observeEvent(input$polyAdd_button, {
        rv$polyMode = "Add"
        if (nrow(rv$polyCoord) != 0) {
            map = leafletProxy("map")
            map = clearShapes(map)
            color = "#6d9192"
            map = addPolygons(map,
                              color=color,
                              lng=rv$polyCoord$lng,
                              lat=rv$polyCoord$lat)
        }
    })
    observeEvent(input$polyRm_button, {
        rv$polyMode = "Rm"
        if (nrow(rv$polyCoord) != 0) {
            map = leafletProxy("map")
            map = clearShapes(map)
            color = "#b35457"
            map = addPolygons(map,
                              color=color,
                              lng=rv$polyCoord$lng,
                              lat=rv$polyCoord$lat)
        }
    })
    
    observeEvent(input$map_click, {
        if (rv$polyMode != 'false' & !rv$clickMode & !rv$downloadMode) {
            rv$polyCoord = bind_rows(rv$polyCoord,
                                     tibble(lng=input$map_click$lng,
                                            lat=input$map_click$lat))
            map = leafletProxy("map")
            map = clearShapes(map)
            if (rv$polyMode == "Add") {
                color = "#6d9192"
            } else if (rv$polyMode == "Rm") {
                color = "#b35457"
            }
            map = addPolygons(map,
                              color=color,
                              lng=rv$polyCoord$lng,
                              lat=rv$polyCoord$lat)
        }
    })
    
    observeEvent(input$polyOk_button, {
        if (nrow(rv$polyCoord) != 0) {
        
            station_coordinates = SpatialPointsDataFrame(
                df_meta()[c('lon', 'lat')],
                df_meta()['code'])

            # Transform them to an sp Polygon
            drawn_polygon = Polygon(as.matrix(rv$polyCoord))
            
            # Use over from the sp package to identify selected station
            selected_station = station_coordinates %over% SpatialPolygons(list(Polygons(list(drawn_polygon), "drawn_polygon")))

            selectCode = df_meta()$code[!is.na(selected_station)]

            if (rv$polyMode == "Add") {
                rv$CodeSample = c(rv$CodeSample, selectCode)
                rv$CodeSample = rv$CodeSample[!duplicated(rv$CodeSample)]
            } else if (rv$polyMode == "Rm") {
                rv$CodeSample = rv$CodeSample[!(rv$CodeSample %in% selectCode)]
            }

            map = leafletProxy("map")
            map = clearShapes(map)
            rv$polyCoord = NULL
        }
        
        rv$polyMode = 'false'
        hide(id='poly_panel')
        showElement(id='ana_panel')
    })

#### 2.4.4. Search ___________________________________________________
    meta_location = reactive({
        gsub("((L'|La |Le )(.*?)aux )|((L'|La |Le )(.*?)au )|((L'|La |Le )(.*?)à )", "", df_meta()$nom)
    })

    meta_river = reactive({
        gsub("(L'|La |Le )| à(.*)| au(.*)| aux(.*)", "", df_meta()$nom)
    })

    meta_basin = reactive({
        df_basinName = tibble(letter=
                                  c('D', 'E',
                                    'A', 'B',
                                    'F', 'G', 'H', 'I',
                                    'J', 'K', 'L', 'M', 'N',
                                    'O', 'P', 'Q', 'R', 'S',
                                    'U', 'V', 'W', 'X', 'Y',
                                    'Z'),
                              basin=
                                  c(rep('Artois-Picardie', 2),
                                    rep('Rhin-Meuse', 2),
                                    rep('Seine-Normandie', 4),
                                    rep('Loire-Bretagne', 5),
                                    rep('Adour-Garonne', 5),
                                    rep('Rhône-Méditérannée & Corse', 5),
                                    rep('Îles', 1)
                                    ))
        fL = substr(df_meta()$code, 1, 1)
        df_basinName$basin[match(fL, df_basinName$letter)]
    })
    
    searchChoices = reactive({
        Values = c(
            paste0("code:", df_meta()$code),
            paste0("name:", df_meta()$nom),
            paste0("region:", df_meta()$region_hydro),
            paste0("regime:", df_meta()$regime_hydro),
            paste0("location:", meta_location()),
            paste0("river:", meta_river()),
            paste0("basin:", meta_basin())
        )
        htmlValues = c(
            paste0(df_meta()$code,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.code"),
                   '</i>'),
            paste0(df_meta()$nom,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.name"),
                   '</i>'),
            paste0(df_meta()$region_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.region"),
                   '</i>'),
            paste0(df_meta()$regime_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.regime"),
                   '</i>'),
            paste0(meta_location(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.location"),
                   '</i>'),
            paste0(meta_river(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.river"),
                   '</i>'),
            paste0(meta_basin(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("a.search.basin"),
                   '</i>')
        )
        
        tibble(value=Values, label=htmlValues, 
               html=htmlValues, stringsAsFactors=FALSE)
    })

    observe({
        updateSelectizeInput(session, 'search_input',
                             choices=searchChoices(),
                             server=TRUE,
                             options=list(
                                 create=FALSE,
                                 placeholder=word("a.search"),
                                 render=I('{
                 item: function(item, escape) {
                    return "<div>" + item.html + "</div>";
                 },
                  option: function(item, escape) {
                    return "<div>" + item.html + "</div>";
                 }
                                 }'),
                                 onDropdownOpen=
                                     I('function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}'),
                                 onType=
                                     I('function (str) {if (str === \"\") {this.close();}}'),
                                 onItemAdd=
                                     I('function() {this.close();}')))
    })
    
    observeEvent(input$search_input, {
        htmlSearch = input$search_input
        Search = gsub("(.*?):", "", htmlSearch)
        searchType = gsub(":(.*)", "", htmlSearch)

        Code = df_meta()$code[df_meta()$code %in% Search[searchType == "code"]]
        CodeNom = df_meta()$code[df_meta()$nom %in% Search[searchType == "name"]]
        CodeRegion = df_meta()$code[df_meta()$region_hydro %in% Search[searchType == "region"]]
        CodeRegime = df_meta()$code[df_meta()$regime_hydro %in% Search[searchType == "regime"]]
        CodeLocation = df_meta()$code[meta_location() %in% Search[searchType == "location"]]
        CodeRiver = df_meta()$code[meta_river() %in% Search[searchType == "river"]]
        CodeBasin = df_meta()$code[meta_basin() %in% Search[searchType == "basin"]]

        selectCode = levels(factor(c(Code,
                                     CodeNom,
                                     CodeRegion,
                                     CodeRegime,
                                     CodeLocation,
                                     CodeRiver,
                                     CodeBasin)))

        if (all(CodeAll() %in% rv$CodeSample)) {
            rv$CodeSample = selectCode
        } else {
            codeRm = rv$CodeSearch[!(rv$CodeSearch %in% selectCode)]        
            rv$CodeSample = rv$CodeSample[!(rv$CodeSample %in% codeRm)]
            rv$CodeSample = c(rv$CodeSample, selectCode)
            rv$CodeSample = rv$CodeSample[!duplicated(rv$CodeSample)] 
        }
        rv$CodeSearch = selectCode
    })
    
    
    observe({
        if (is.null(input$search_input) & !is.null(rv$Search_save)) {
            rv$CodeSample = rv$CodeSample_save
        }
        if (is.null(input$search_input) & is.null(rv$Search_save)) {
            rv$CodeSample_save = rv$CodeSample
        }
        rv$Search_save = input$search_input
    })
    
### 2.5. Trend analysis ______________________________________________
    df_Xtrend = reactive({
        if (!is.null(df_XEx())) {
            Estimate_stats_WRAP(df_XEx=df_XEx(),
                                dep_option='AR1')
        } else {
            NULL
        }
    })

### 2.6. Color _______________________________________________________
    fillList = reactive({
        nCodeAll = length(CodeAll())
        
        if (!is.null(df_XEx()) | !is.null(df_Xtrend())) {            
            res = get_trendExtremes(df_XEx(), df_Xtrend(),
                                    CodeAll=CodeAll(),
                                    CodeSample=CodeSample(),
                                    toMean=TRUE)

            rv$TrendValues = res$values
            rv$minTrendValue = res$min
            rv$maxTrendValue = res$max
            
            fillListtmp = c()
            for (k in 1:nCodeAll) {

                code = CodeAll()[k]
                
                if (code %in% CodeSample()) {
                    trendValue = rv$TrendValues[k]

                    color = get_color(trendValue, 
                                      rv$minTrendValue,
                                      rv$maxTrendValue,
                                      nbTick=nbTick,
                                      palette_name='perso',
                                      reverse=TRUE)
                } else {
                    if (input$theme_choice == 'terrain' | input$theme_choice == 'light') {
                        color = grey94COL
                    } else if (input$theme_choice == 'dark') {
                        color = grey18COL
                    }
                }
                
                fillListtmp = c(fillListtmp, color)
            }
            fillListtmp
        } else {
            rep(grey50COL, nCodeAll)
        }
    })


### 2.7. Trend plot __________________________________________________
    observeEvent({
        input$map_marker_click
        period()
        var()
    }, {
        if (rv$polyMode == 'false' & !rv$clickMode & !rv$downloadMode & !is.null(input$map_marker_click)) {
            showElement(id='plot_panel')
            
            codeClick = input$map_marker_click$id

            df_data_code = df_XEx()[df_XEx()$code == codeClick,]
            df_Xtrend_code = df_Xtrend()[df_Xtrend()$code == codeClick,]
            color = fillList()[CodeAll() == codeClick]
            
            output$trend_plot = renderPlot({
                plot_time_panel(df_data_code=df_data_code,
                                df_Xtrend_code=df_Xtrend_code,
                                var=var(),
                                type=type(),
                                linetype='solid',
                                alpha=input$alpha_choice,
                                missRect=FALSE,
                                trend_period=period(),
                                axis_xlim=period(),
                                grid=FALSE,
                                color=color,
                                NspaceMax=NULL,
                                first=FALSE,
                                last=TRUE,
                                lim_pct=10)
            }, width=500, height=200, res=300)
        }
    })

    observeEvent(input$closePlot_button, {
        hide(id='plot_panel')
    })
    

## 3. CUSTOMIZATION __________________________________________________
### 3.2. Palette _____________________________________________________
    observeEvent(input$colorbar_choice, {
        if (input$colorbar_choice == 'show') {
            showElement(id="colorbar_panel")
        } else if (input$colorbar_choice == 'none') {
            hide(id="colorbar_panel")
        }
    })

    observeEvent({
        rv$minTrendValue
        rv$maxTrendValue
        input$colorbar_choice
    }, {
        if (input$colorbar_choice == 'show') {
            output$colorbar_plot = renderPlot({
                plot_colorbar(rv$minTrendValue, rv$maxTrendValue,
                              palette_name=palette_name,
                              reverse=palette_reverse, nbTick=nbTick)
            }, width=55, height=250, res=300)
        }
    })

    
## 4. INFO ___________________________________________________________
    observeEvent(input$info_button, {
        toggle(id='info_panel')
        hide(id='ana_panel')
        hide(id='theme_panel')
    })

    
## 5. SAVE ___________________________________________________________
### 5.1. Download ____________________________________________________
    observeEvent(input$download_button, {
        hide(id='ana_panel')
        hide(id='theme_panel')
        hide(id='info_panel')
        hide(id='poly_panel')
        hide(id='click_panel')
        showElement(id='download_panel')
        rv$downloadMode = TRUE
    })


    observeEvent(input$map_marker_click, {
        if (rv$polyMode == 'false' & !rv$clickMode & rv$downloadMode) {
            codeClick = input$map_marker_click$id

            output$downloadData = downloadHandler(
                filename = function () {
                    paste0(codeClick, ".pdf")
                },
                content = function (file) {
                    name = paste0(codeClick, ".pdf")
                    from = file.path(computer_data_path, 'pdf', name)
                    file.copy(from, file)
                }
            )
            jsinject = "setTimeout(function()
                        {window.open($('#downloadData')
                        .attr('href'))}, 100);"
            session$sendCustomMessage(type='jsCode',
                                      list(value=jsinject))    
        }
    })

    observeEvent(input$downloadOk_button, {
        rv$downloadMode = FALSE
        hide(id='download_panel')
    })
    
            
### 5.2. Screenshot __________________________________________________
    observe({
        delay(100,
              runjs('
$("#colorbar_panel").insertAfter($("#map_div .leaflet-pane.leaflet-map-pane"));
$("#colorbar_panel").css("position", "absolute");
$("#colorbar_panel").css("z-index", "999");')
        )
    })

    observeEvent(input$photo_button, {
        rv$inputPhoto = !rv$inputPhoto
    })

    inputPhotoDEB = reactive({
        rv$inputPhoto
    })
    
    inputPhotoDEB = debounce(inputPhotoDEB, 500)

    observe({
        if (inputPhotoDEB()) {
            map = leafletProxy("map")
            easyprintMap(map, sizeModes="A4Landscape", dpi=300)
            rv$inputPhoto = FALSE
        }
    })

} 

