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

    if (file.exists(dev_path)) {
        session$onSessionEnded(stopApp)
        verbose = TRUE
    } else {
        verbose = FALSE
    }

    rv = reactiveValues(start=FALSE,
                        width=0,
                        height=0,
                        CodeSample=NULL,
                        CodeSample_save=NULL,
                        CodeSampleCheck=NULL,
                        CodeSearch=NULL,
                        markerListAll_save=NULL,
                        Search_save=NULL,
                        polyCoord=NULL,
                        theme_choice_save=NULL,
                        mapHTML=NULL,
                        polyMode='false',
                        clickMode=FALSE,
                        warningMode=TRUE,
                        dlClickMode=FALSE,
                        photoMode=FALSE,
                        invertSliderMode=FALSE,
                        sampleSliderMode=FALSE,
                        optimalMode=FALSE,
                        optimalMode_act=FALSE,
                        currentLimits=NULL,
                        map_bounds=NULL, 
                        mapPreview_bounds=NULL,
                        defaultBounds=NULL,
                        value=NULL,
                        valueSample=NULL,
                        minValue=NULL,
                        maxValue=NULL,
                        helpPage=NULL,
                        helpPage_prev=NULL,
                        sizeList=NULL,
                        shapeList=NULL,
                        colorList=NULL,
                        fillList=NULL,
                        codeClick=NULL,
                        missCode=c(),
                        invalidCode=c(),
                        badCode=c(),
                        actualise=FALSE,
                        df_XEx=NULL,
                        df_Xtrend=NULL,
                        period=NULL,
                        hydroPeriod=NULL,
                        var=FALSE,
                        type=NULL,
                        unit=NULL,
                        proba=NULL,
                        reverse=FALSE,
                        CodeSample_act=NULL,
                        CodeAdd=NULL,
                        actualiseForce=FALSE,
                        loading=FALSE
                        )

    startOBS = observe({
        showElement(id="zoom_panelButton")
        showElement(id='ana_panelButton')
        showElement(id='theme_panelButton')
        showElement(id='photo_panelButton')
        showElement(id='download_panelButton')
        showElement(id='help_panelButton')
        rv$start = TRUE
        startOBS$destroy()
    })

    
## 1. MAP ____________________________________________________________
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
            Lon = df_meta()$lon[df_meta()$Code %in% CodeSample()]
            Lat = df_meta()$lat[df_meta()$Code %in% CodeSample()]
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
        input$theme_choice
    }, {

        windowChange = input$dimension[1] != rv$width | input$dimension[2] != rv$height

        if (!identical(windowChange, logical(0))) {
            if (windowChange) {
                rv$defaultBounds = input$map_bounds
                rv$width = input$dimension[1]
                rv$height = input$dimension[2]
            }

            error = 0.1
            
            isDefault = all(abs(unlist(input$map_bounds) - unlist(rv$defaultBounds)) <= error)
            
            isFocus = all(abs(unlist(input$map_bounds) - unlist(rv$mapPreview_bounds)) <= error)

            if (windowChange) {
                isDefault = TRUE
                isFocus = TRUE
            }

            if (isDefault & isFocus & is.null(rv$helpPage)) {
                hide(id='focusZoom_panelButton')
                hide(id='defaultZoom_panelButton')
                
            } else if (isDefault & !isFocus) {
                showElement(id='focusZoom_panelButton')
                hide(id='defaultZoom_panelButton')
                
            } else if (!isDefault & isFocus) {
                hide(id='focusZoom_panelButton')
                showElement(id='defaultZoom_panelButton')
                
            } else if (!isDefault & !isFocus) {
                showElement(id='focusZoom_panelButton')
                hide(id='defaultZoom_panelButton')
            }
        }
    })

### 1.3. Marker ______________________________________________________
    markerListAll = reactive({

        if (input$theme_choice == 'terrain' | input$theme_choice == 'light') {
            none1Color = none1Color_light
        } else if (input$theme_choice == 'dark') {
            none1Color = none1Color_dark
        }
        
        if (input$theme_choice == 'terrain' | input$theme_choice == 'light') {
            none2Color = none2Color_light
        } else if (input$theme_choice == 'dark') {
            none2Color = none2Color_dark
        }
        
        if (!is.null(rv$df_XEx) | !is.null(rv$df_Xtrend)) {
            
            trendCode = rv$df_Xtrend$Code

            sizeList = rep('small', nCodeAll())
            sizeList[match(rv$codeClick, CodeAll())] = 'big'

            rv$sizeList = sizeList
            
            OkS = rv$df_Xtrend$p <= input$alpha_choice
            CodeSU = trendCode[OkS & rv$df_Xtrend$trend >= 0]
            CodeSD = trendCode[OkS & rv$df_Xtrend$trend < 0]
            CodeNS = trendCode[!OkS]
            
            shapeList = rep('o', nCodeAll())
            shapeList[match(CodeSU, CodeAll())] = '^'
            shapeList[match(CodeSD, CodeAll())] = 'v'
            shapeList[match(CodeNS, CodeAll())] = 'o'
            shapeList[match(missCode(), CodeAll())] = 'o'

            rv$shapeList = shapeList
            
            colorList = rep(none1Color, nCodeAll())
            colorList[match(CodeSample(), CodeAll())] = validColor
            invalidCodeSample = invalidCode()[invalidCode() %in% CodeSample()]
            colorList[match(invalidCodeSample, CodeAll())] = invalidColor
            missCodeSample = missCode()[missCode() %in% CodeSample()]
            colorList[match(missCodeSample, CodeAll())] = missColor

            rv$colorList = colorList

            res = get_trendExtremesMOD(rv$df_XEx, rv$df_Xtrend,
                                       unit=rv$unit,
                                       minQprob=exQprob,
                                       maxQprob=1-exQprob,
                                       CodeSample=CodeSample())
            
            rv$df_value = res$df_value
            rv$df_valueSample = res$df_valueSample
            rv$minValue = res$min
            rv$maxValue = res$max

            print(res$min)
            print(res$max)

            fill = get_color(rv$df_value$value,
                             rv$minValue,
                             rv$maxValue,
                             Palette=Palette,
                             colorStep=colorStep,
                             reverse=rv$reverse,
                             noneColor=none2Color)
            
            fillList = rep(none2Color, nCodeAll())
            fillCode = rv$df_value$Code
            
            okCodeSample = fillCode %in% CodeSample()
            fillCodeSample = fillCode[okCodeSample]
            fillSample = fill[okCodeSample]

            fillList[match(fillCodeSample, CodeAll())] = fillSample

            rv$fillList = fillList
            
            
        } else {
            sizeList = rep('small', nCodeAll())
            shapeList = rep('o', nCodeAll())                        
            colorList = rep(none1Color, nCodeAll())            
            fillList = rep(none2Color, nCodeAll())
        }
        
        get_markerList(sizeList,
                       shapeList,
                       colorList,
                       fillList,
                       resources_path)
    })
    
    observeEvent({
        input$theme_choice
        input$alpha_choice
        df_meta()
        markerListAll()
    }, {

        map = leafletProxy("map")
        
        if (input$theme_choice != rv$theme_choice_save | is.null(unlist(rv$markerListAll_save$iconUrl))) {
            okCode = rep(TRUE, nCodeAll())
        } else {
            okCode = unlist(markerListAll()$iconUrl) != unlist(rv$markerListAll_save$iconUrl)
        }
        rv$theme_choice_save = input$theme_choice

        Code = CodeAll()[okCode]
        markerList = markerListAll()
        markerList$iconUrl = markerListAll()$iconUrl[okCode]
        Lon = df_meta()$lon[okCode]
        Lat = df_meta()$lat[okCode]
        Nom = df_meta()$nom[okCode]
        Sup = df_meta()$surface_km2_BH[okCode]
        Alt = df_meta()$altitude_m_BH[okCode]

        if (!is.null(rv$df_XEx) & !is.null(rv$df_Xtrend)) {            
            trendLabel = sapply(Code, get_trendLabel,
                                df_XEx=rv$df_XEx,
                                df_Xtrend=rv$df_Xtrend,
                                unit=rv$unit)
        } else {
            trendLabel = NA
        }

        Br = rep("<br>", times=length(Code))
        Br[is.na(trendLabel)] = ""
        trendLabel[is.na(trendLabel)] = ""

        trendColor = rv$fillList[match(Code, CodeAll())]
        trendColor = sapply(trendColor, switch_colorLabel)
        
        n = 4
        label = paste0(
            '<b style="color:#00a3a6">', Code," </b>", ' - ',
            '<span style="color:#00a3a6">', Nom," </span>",
            '<br>',
            '<span style="color:',  trendColor,'">', trendLabel, "</span>",
            Br,

            '<table>',
            "<tr>",
            "<td>",
            '<b style="color:',  grey20COL,'">',
            word('m.hov.lat'), " : ", format(signif(Lat, n), nsmall=n), "</b>",
            "&emsp;", "</td>",
            "<td>",
            '<b style="color:',  grey20COL,'">',
            word('m.hov.sup'), " : ", round(Sup),
            " km<sup>2</sup></b>",
            "</td>",
            "</tr>",

            "<tr>",
            "<td>",
            '<b style="color:',  grey20COL,'">',
            word('m.hov.lon'), " : ", format(signif(Lon, n), nsmall=n), "</b>",
            "&emsp;", "</td>",
            "<td>",
            '<b style="color:',  grey20COL,'">',
            word('m.hov.alt'), " : ", round(Alt), " m</b>",
            "</td>",
            "</tr>",
            "</table>"
        )

        map = removeMarker(map, layerId=Code)
        map = addMarkers(map,
                         lng=Lon,
                         lat=Lat,
                         icon=markerList,
                         label=lapply(label, HTML),
                         layerId=Code)

        rv$markerListAll_save = markerListAll()
    })    
    

## 2. ANALYSE ________________________________________________________
    observeEvent(input$ana_button, {
        toggleOnly(id="ana_panel")
        deselect_mode(session, rv)
    })

### 2.1. Station metadata ____________________________________________
    df_meta = reactive({
        df_metatmp = read_FST(computer_data_path,
                              'meta.fst',
                              filedir='fst')
        crs_rgf93 = sf::st_crs(2154)
        crs_wgs84 = sf::st_crs(4326)
        sf_loca = sf::st_as_sf(df_metatmp[c("L93X_m_BH", "L93Y_m_BH")],
                               coords=c("L93X_m_BH", "L93Y_m_BH"))
        sf::st_crs(sf_loca) = crs_rgf93
        sf_loca = sf::st_transform(sf_loca, crs_wgs84)
        sf_loca = sf::st_coordinates(sf_loca$geometry)
        df_metatmp$lon = sf_loca[, 1]
        df_metatmp$lat = sf_loca[, 2]
        df_metatmp = df_metatmp[order(df_metatmp$Code),]
        df_metatmp
    })

### 2.2. Station selection ___________________________________________
    CodeAll = reactive({
        rle(df_meta()$Code)$values
    })

    nCodeAll = reactive({
        length(CodeAll())
    })

    rv$CodeSample = isolate(CodeAll())
    rv$CodeSample_save = isolate(CodeAll())
    rv$theme_choice_save = isolate(input$theme_choice)

    CodeSampleCheck = reactive({
        if (!rv$warningMode) {
            rv$CodeSample[!(rv$CodeSample %in% badCode())]
        } else {
            rv$CodeSample
        }
    })

    CodeSample = reactive({
        if (identical(CodeSampleCheck(), character(0))) {
            NULL
        } else {
            CodeSampleCheck()
        }
    })

#### 2.2.1. All/none _________________________________________________
    observeEvent(input$all_button, {
        rv$CodeSample = CodeAll()
    })

    observeEvent(input$none_button, {
        updateSelectizeInput(session, 'search_input',
                             selected="")
        rv$CodeSample = NULL
    })
    
#### 2.2.2. Map click ________________________________________________
    observe({
        if (!is.null(input$click_select)) {
            hide(id='ana_panel')
            hide(id='theme_panel')
            hide(id='info_panel')
            hide(id='photo_bar')
            hide(id='download_bar')
            hide(id='poly_bar')
            hide(id='dlClick_bar')
            showElement(id='click_bar')
            rv$clickMode = TRUE
        } else {
            if (rv$clickMode) {
                deselect_mode(session, rv)
                hide(id='click_bar')
                showElement(id='ana_panel')
            }
        }
    })

    observeEvent(input$map_marker_click, {
        if (rv$polyMode == 'false' & rv$clickMode & !rv$dlClickMode & !rv$photoMode) {
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
        deselect_mode(session, rv)                
        hide(id='click_bar')
        hide(id='theme_panel')
        showElement(id='ana_panel')
    })

#### 2.2.3. Polygone _________________________________________________
    observe({
        if (!is.null(input$poly_select)) {
            if (rv$polyMode != 'Add' & rv$polyMode != 'Rm') {
                hide(id='ana_panel')
                hide(id='theme_panel')
                hide(id='info_panel')
                hide(id='photo_bar')
                hide(id='download_bar')
                hide(id='click_bar')
                hide(id='dlClick_bar')
                showElement(id='poly_bar')
                rv$polyMode = input$poly_choice
                rv$polyCoord = tibble()
            }
        } else {
            if (rv$polyMode == 'Add' | rv$polyMode == 'Rm') {
                deselect_mode(session, rv)
                hide(id='poly_bar')
                showElement(id='ana_panel')
            }
        }
    })

    observeEvent(input$poly_choice, {

        if (!is.null(input$poly_choice) & !is.null(rv$polyCoord)) {
            if (input$poly_choice == 'Add') {
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
            } else if (input$poly_choice == 'Rm') {
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
            }
        }
    })
    
    observeEvent(input$map_click, {
        if (rv$polyMode != 'false' & !rv$clickMode & !rv$dlClickMode & !rv$photoMode) {
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
        
            station_coordinates = sp::SpatialPointsDataFrame(
                df_meta()[c('lon', 'lat')],
                df_meta()['Code'])

            # Transform them to an sp Polygon
            drawn_polygon = sp::Polygon(as.matrix(rv$polyCoord))
            
            # Use over from the sp package to identify selected station
            selected_station = sp::over(station_coordinates, sp::SpatialPolygons(list(sp::Polygons(list(drawn_polygon), "drawn_polygon"))))

            selectCode = df_meta()$Code[!is.na(selected_station)]

            if (rv$polyMode == "Add") {
                rv$CodeSample = c(rv$CodeSample, selectCode)
                rv$CodeSample = rv$CodeSample[!duplicated(rv$CodeSample)]
            } else if (rv$polyMode == "Rm") {
                rv$CodeSample = rv$CodeSample[!(rv$CodeSample %in% selectCode)]
            }

            map = leafletProxy("map")
            map = clearShapes(map)
        }
        deselect_mode(session, rv)
    })

#### 2.2.4. Warning __________________________________________________
    observe({        
        if (!is.null(input$warning_select)) {
            rv$warningMode = TRUE
        } else {
            rv$warningMode = FALSE
        }
    })

#### 2.2.5. Search ___________________________________________________
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
        fL = substr(df_meta()$Code, 1, 1)
        df_basinName$basin[match(fL, df_basinName$letter)]
    })
    
    searchChoices = reactive({
        Values = c(
            paste0("code:", df_meta()$Code),
            paste0("name:", df_meta()$nom),
            paste0("region:", df_meta()$region_hydro),
            paste0("regime:", df_meta()$regime_hydro),
            paste0("location:", meta_location()),
            paste0("river:", meta_river()),
            paste0("basin:", meta_basin())
        )
        htmlValues = c(
            paste0(df_meta()$Code,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.code"),
                   '</i>'),
            paste0(df_meta()$nom,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.name"),
                   '</i>'),
            paste0(df_meta()$region_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.region"),
                   '</i>'),
            paste0(df_meta()$regime_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.regime"),
                   '</i>'),
            paste0(meta_location(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.location"),
                   '</i>'),
            paste0(meta_river(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.river"),
                   '</i>'),
            paste0(meta_basin(),
                   '<i style="font-size: 9pt; color: ',
                   grey85COL, '">&emsp;', word("ana.search.basin"),
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
                                 placeholder=word("ana.search"),
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

        Code = df_meta()$Code[df_meta()$Code %in% Search[searchType == "code"]]
        CodeNom = df_meta()$Code[df_meta()$nom %in% Search[searchType == "name"]]
        CodeRegion = df_meta()$Code[df_meta()$region_hydro %in% Search[searchType == "region"]]
        CodeRegime = df_meta()$Code[df_meta()$regime_hydro %in% Search[searchType == "regime"]]
        CodeLocation = df_meta()$Code[meta_location() %in% Search[searchType == "location"]]
        CodeRiver = df_meta()$Code[meta_river() %in% Search[searchType == "river"]]
        CodeBasin = df_meta()$Code[meta_basin() %in% Search[searchType == "basin"]]

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

### 2.3. Variable extration __________________________________________
    observeEvent(input$event_choice, {

        var_event = Var$var[Var$event == input$event_choice]
        varHTML_event = Var$varHTML[Var$event == input$event_choice]
        name_event = Var$name[Var$event == input$event_choice]

        updateRadioButton(session,
                          class="radioButton",
                          inputId="var_choice",
                          choiceValues=var_event,
                          choiceNames=varHTML_event,
                          choiceTooltips=name_event,
                          selected=var_event[1])
    })

    var = reactive({
        if (!is.null(input$var_choice) & input$var_choice != FALSE) {
            input$var_choice
        } else {
            Var$var[1]
        }
    })

    type = reactive({
        Var$type[Var$var == rv$var]            
    })

    proba_choices = reactive({
        id = which(Var$var == var())
        if (!identical(id, integer(0))) {
            Var$proba[[id]]
        } else {
            NULL
        }
    })

    proba = reactive({
        if (!is.null(proba_choices())) {
            input$proba_choice
        } else {
            NULL
        }
    })

    reverse = reactive({
        id = which(Var$var == var())
        if (!identical(id, integer(0))) {
            Var$reverse[id]
        } else {
            FALSE
        }
    })
    
    output$varHTML = renderUI({
        if (is.null(rv$proba)) {
            HTML(paste0(
                "<b>",
                Var$varHTML[Var$var == rv$var],
                "</b>"
            ))
        } else {
            HTML(paste0(
                "<b>",
                gsub('p', gsub("%", "", rv$proba),
                     Var$varHTML[Var$var == rv$var]),
                "</b>"
            ))
        }
    })

    output$nameHTML = renderUI({
        if (is.null(rv$proba)) {
            name = Var$name[Var$var == rv$var]
        } else {
            name = gsub('p', gsub("%", "", rv$proba),
                        Var$name[Var$var == rv$var])
        }
        nbNewline = 0
        nbLim = 24
        nbChar = nchar(name)
        while (nbChar > nbLim) {
            nbNewline = nbNewline + 1
            posSpace = which(strsplit(name, "")[[1]] == " ")
            idNewline = which.min(abs(posSpace - nbLim * nbNewline))
            posNewline = posSpace[idNewline]
            name = paste(substring(name,
                                   c(1, posNewline + 1),
                                   c(posNewline,
                                     nchar(name))),
                         collapse="<br>")
            Newline = substr(name,
                             posNewline + 2,
                             nchar(name))
            nbChar = nchar(Newline)
        }
        HTML(name)
    })

    output$dataHTML_ana = renderUI({
        if (is.null(proba())) {
            data = paste0(Var$varHTML[Var$var == var()], ' : ',
                          Var$name[Var$var == var()])
        } else {
            data = paste0(gsub('p', gsub("%", "", proba()),
                               Var$varHTML[Var$var == var()]), ' : ',
                          gsub('p', gsub("%", "", proba()),
                               Var$name[Var$var == var()]))
        }
        HTML(data)
    })

    observe({
        if (!is.null(proba_choices())) {
            showElement(id="proba_row")
            choices = proba_choices()
        } else {
            hide(id="proba_row")
            choices = FALSE
        }
        updateRadioButton(session,
                          class="radioButton",
                          inputId="proba_choice",
                          choiceNames=choices,
                          choiceTooltips=
                              paste0(word("tt.ana.proba"), " ", choices))
    })



### 2.4. _____________________________________________________________
    observe({
        if (!is.null(input$optimalSlider_select)) {
            rv$optimalMode = TRUE
            hide(id="sampleSlider")
        } else {
            rv$optimalMode = FALSE
            showElement(id="sampleSlider")
        }
    })
    
    observe({
        if (!is.null(input$sampleSlider_select)) {
            rv$sampleSliderMode = TRUE
            showElement(id="invertSlider")
        } else {
            rv$sampleSliderMode = FALSE
            hide(id="invertSlider")
        }
    })

    observe({
        if (!is.null(input$invertSlider_select)) {
            rv$invertSliderMode = TRUE
        } else {
            rv$invertSliderMode = FALSE
        }
    })

    observeEvent({
        rv$sampleSliderMode
        rv$invertSliderMode
        rv$optimalMode
    }, {

        if (!is.null(input$hydroPeriod_slider)) {
            hydroMonths = match(input$hydroPeriod_slider, Months)
        } else {
            hydroMonths = 1
        }
        
        if (rv$optimalMode) {
            class = "size1Slider noneSlider"
            selected = Months[hydroMonths[1]]

        } else if (rv$sampleSliderMode) {
            if (rv$invertSliderMode) {
                class = "size1Slider invertSlider"
                if (length(hydroMonths) == 1) {
                    selected = Months[c(1, hydroMonths)]
                } else {
                    selected = Months[hydroMonths]
                }
                
            } else {
                class = "size1Slider"
                if (length(input$hydroPeriod_slider) == 1) {
                    selected = Months[c(hydroMonths, 12)]
                } else {
                    selected = Months[hydroMonths]
                }
            }           
        } else {
            class = "size1Slider soloSlider"
            selected = Months[hydroMonths[1]]
        }
        
        output$hydroPeriod_slider = renderUI({
            Slider(class=class,
                   inputId="hydroPeriod_slider",
                   modeText=TRUE,
                   label=NULL,
                   grid=TRUE,
                   force_edges=FALSE,
                   choices=Months,
                   selected=selected)
        })
    })

    output$dateYear_slider = renderUI({
        Slider(class="size2Slider",
               inputId="dateYear_slider",
               label=NULL,
               step=1,
               sep='',
               min=1900,
               max=2020,
               value=c(1968, 2020))
    })
        

    hydroPeriodB = reactive({
        if (!is.null(input$hydroPeriod_slider)) {
            if (rv$sampleSliderMode & length(input$hydroPeriod_slider) == 2) {
                if (rv$invertSliderMode) {
                    nameMonthStart = input$hydroPeriod_slider[2]
                    idMonthStart = which(Months == nameMonthStart)
                    monthStart = formatC(idMonthStart, width=2, flag=0)

                    nameMonthEnd = input$hydroPeriod_slider[1]
                    idMonthEnd = which(Months == nameMonthEnd)
                    monthEnd = formatC(idMonthEnd, width=2, flag=0)            
                    dateEnd = as.Date(paste0("1972-", monthEnd, "-01"))
                    
                    hydroPeriodStart = paste0(monthStart, "-01")
                    hydroPeriodEnd = substr(dateEnd - 1, 6, 10)
                    
                } else {
                    nameMonthStart = input$hydroPeriod_slider[1]
                    idMonthStart = which(Months == nameMonthStart)
                    monthStart = formatC(idMonthStart, width=2, flag=0)

                    nameMonthEnd = input$hydroPeriod_slider[2]
                    idMonthEnd = which(Months == nameMonthEnd)
                    monthEnd = formatC(idMonthEnd, width=2, flag=0)
                    dateEnd = as.Date(paste0("1972-", monthEnd, "-01"))

                    hydroPeriodStart = paste0(monthStart, "-01")
                    hydroPeriodEnd = substr(dateEnd + months(1) - 1, 6, 10)
                }
                c(hydroPeriodStart, hydroPeriodEnd)

            } else if (rv$optimalMode) {
                rv$hydroPeriod
            } else {
                nameMonthStart = input$hydroPeriod_slider[1]
                idMonthStart = which(Months == nameMonthStart)
                monthStart = formatC(idMonthStart, width=2, flag=0)
                hydroPeriodStart = paste0(monthStart, "-01")
                hydroPeriodStart
            }
        } else {
            "01-01"
        }
    })
    hydroPeriod = debounce(hydroPeriodB, 1000)

    output$hydroPeriodHTML = renderUI({
        if (rv$optimalMode_act) {
            HTML(word("out.optimal"))
        } else {
            hydroStart = format(rv$period[1], "%d %b")
            hydroEnd = format(rv$period[2], "%d %b")
            HTML(paste0(word("out.hp"), "<br>",
                        word("out.from"), " ",
                        hydroStart, " ",
                        word("out.to"), " ",
                        hydroEnd))
        }
    })    
    
    df_dataAll = reactive({
        if (file.exists(file.path(computer_data_path, 'fst', "data.fst"))) {
            read_FST(computer_data_path,
                     "data.fst",
                     filedir="fst")
        } else {
            NULL
        }
    })

    df_data = reactive({
        if (!is.null(df_dataAll()) & !is.null(CodeSample())) {
            df_dataAll()[df_dataAll()$Code %in% CodeSample(),]
        } else {
            NULL
        }
    })

    observeEvent({
        CodeSample()
        var()
        period()
        proba()
        hydroPeriod()
        rv$photoMode
        rv$optimalMode
    }, {
        if (!is.null(CodeSample()) & !is.null(rv$CodeSample_act)) {
            if (!all(CodeSample() %in% rv$CodeSample_act)) {
                rv$CodeAdd = CodeSample()[!(CodeSample() %in% rv$CodeSample_act)]
                rv$actualiseForce = !rv$actualiseForce
            }
        }
        
        if (identical(var(), rv$var) & all(identical(period(), rv$period)) & identical(proba(), rv$proba) & all(identical(hydroPeriod(), rv$hydroPeriod)) & is.null(rv$helpPage) & identical(rv$optimalMode, rv$optimalMode_act)) {
            hide(id="actualise_panelButton")    
        } else {
            if ((rv$var != FALSE | !is.null(rv$period) | !is.null(rv$proba) | !is.null(rv$hydroPeriod)) & !rv$photoMode) {
                showElement(id="actualise_panelButton")
            }
        }
    })

    observeEvent({
        input$actualise_button
        rv$actualiseForce
        rv$start
    }, {       
        if (!is.null(df_data()) & !is.null(df_meta()) & var() != FALSE & !is.null(period())) {
            rv$actualise = TRUE
            showElement(id="loading_panel")
        }
    })

    observeEvent(rv$actualise, {

        if (rv$actualise) {

            rv$CodeSample_act = c(CodeSample(), rv$CodeAdd)
            rv$CodeSample_act = sort(rv$CodeSample_act)
            rv$optimalMode_act = rv$optimalMode
            rv$var = var()
            rv$type = type()
            rv$period = period()
            rv$proba = proba()
            rv$hydroPeriod = hydroPeriod()
            rv$reverse = reverse()

            if (!is.null(rv$CodeAdd)) {
                df_data = df_data()[df_data()$Code %in% rv$CodeAdd,]
            } else {
                df_data = df_data()
            }
            
            hide(id="actualise_panelButton")
            
            if (grepl(".*p$", rv$var)) {
                if (rv$proba != FALSE & !is.null(proba_choices())) {
                    filename = paste0(gsub("p", "",
                                           rv$var),
                                      gsub("%", "", rv$proba),
                                      ".R")
                } else {
                    filename = NULL
                }
            } else {
                filename = paste0(rv$var, ".R")
            }

            if (!is.null(filename)) {
                script_to_analyse_path = file.path('R',
                                                   var_dir,
                                                   filename)
                source(file.path('R', var_dir, init_var_file),
                       encoding='UTF-8')
                source(file.path('R', var_dir, init_tools_file),
                       encoding='UTF-8')
                source(script_to_analyse_path,
                       encoding='UTF-8')

                rv$unit = unit

                if (rv$optimalMode_act) {
                    event = Var$event[Var$var == rv$var]
                    if (identical(hydroPeriod_opti[[event]], "min")) {
                        minQM_code = df_meta()$minQM[df_meta()$Code %in% rv$CodeSample_act]
                        Value = paste0(formatC(minQM_code,
                                               width=2,
                                               flag="0"),
                                       '-01')
                        hydroPeriod_analyse = tibble(Code=rv$CodeSample_act,
                                             Value=Value)
                    } else if (identical(hydroPeriod_opti[[event]], "max")) {
                        maxQM_code = df_meta()$maxQM[df_meta()$Code %in% rv$CodeSample_act]
                        Value = paste0(formatC(maxQM_code,
                                               width=2,
                                               flag="0"),
                                       '-01')
                        hydroPeriod_analyse = tibble(Code=rv$CodeSample_act,
                                             Value=Value)
                    } else {
                        hydroPeriod_analyse = hydroPeriod_opti[[event]]
                    }
                } else {
                    hydroPeriod_analyse = rv$hydroPeriod
                }

                res = get_Xtrend(rv$var,
                                 df_data,
                                 period=list(rv$period),
                                 hydroPeriod=hydroPeriod_analyse,
                                 df_flag=df_flag,
                                 yearNA_lim=yearNA_lim,
                                 dayNA_lim=dayNA_lim,
                                 day_to_roll=day_to_roll,
                                 functM=functM,
                                 functM_args=functM_args,
                                 isDateM=isDateM,
                                 functY=functY,
                                 functY_args=functY_args,
                                 isDateY=isDateY,
                                 functYT_ext=functYT_ext,
                                 functYT_ext_args=functYT_ext_args,
                                 isDateYT_ext=isDateYT_ext,
                                 functYT_sum=functYT_sum,
                                 functYT_sum_args=functYT_sum_args,
                                 verbose=verbose)

                # Gets the extracted data for the variable
                df_XEx = res$analyse$extract
                # Gets the trend results for the variable
                df_Xtrend = res$analyse$estimate
                df_Xtrend = df_Xtrend[!is.na(df_Xtrend$trend),]

                if (!is.null(rv$CodeAdd)) {
                    df_XEx = bind_rows(rv$df_XEx, df_XEx)
                    df_XEx = df_XEx[order(df_XEx$Code),]
                    df_Xtrend = bind_rows(rv$df_Xtrend, df_Xtrend)
                    df_Xtrend = df_Xtrend[order(df_Xtrend$Code),]
                    rv$CodeAdd = NULL
                }

                df_XEx = df_XEx[df_XEx$Code %in% CodeSample(),]
                df_Xtrend = df_Xtrend[df_Xtrend$Code %in% CodeSample(),]

                rv$df_XEx = df_XEx
                rv$df_Xtrend = df_Xtrend

            } else {
                rv$df_XEx = NULL
                rv$df_Xtrend = NULL
            }
        }
        rv$actualise = FALSE
        hide(id="loading_panel")
    })
    

### 2.4. Period ______________________________________________________
    periodB = reactive({

        if (!is.null(input$dateYear_slider)) {
            startYear = input$dateYear_slider[1]
            endYear = input$dateYear_slider[2]
        } else {
            startYear = 1968
            endYear = 2020
        }
        
        if (!is.null(hydroPeriod())) {    
            inter = endYear - startYear
            if (inter < 30) {
                if (startYear + 30 > 2020 & endYear - 30 >= 1900) {
                    startYear = endYear - 30
                } else {
                    endYear = startYear + 30
                }
                updateSlider(session=session,
                             class="size2Slider",
                             inputId="dateYear_slider",
                             value=c(startYear, endYear))
            }

            if (rv$sampleSliderMode & length(hydroPeriod()) == 2) {
                Start = as.Date(paste0(startYear,
                                       "-",
                                       hydroPeriod()[1]))
                End = as.Date(paste0(endYear,
                                     "-",
                                     hydroPeriod()[2]))
                c(Start, End)

            } else {                
                Start = as.Date(paste0(startYear,
                                       "-",
                                       hydroPeriod()[1]))
                Endtmp = as.Date(paste0(endYear,
                                        "-",
                                        hydroPeriod()[1])) - 1
                End = as.Date(paste0(endYear,
                                     "-",
                                     substr(Endtmp, 6, 10)))
                c(Start, End)
            }
        } else {
            NULL
        }
    })
    period = debounce(periodB, 1000)

    output$period_ana = renderText({        
        start = format(periodB()[1], "%d/%m/%Y")
        end = format(periodB()[2], "%d/%m/%Y")
        paste0('Du ', start, ' au ', end)
    })

    output$period = renderText({
        start = format(rv$period[1], "%Y")
        end = format(rv$period[2], "%Y")
        paste0('Période ', start, ' - ', end)
    })
    
    
### 2.5. Trend analysis ______________________________________________
    output$significativite = renderText({
        paste0('Significativité de ',
               as.numeric(input$alpha_choice)*100, '%')
    })

    missCode = reactive({
        if (!is.null(df_dataAll())) {
            Start = rv$period[1]
            End = rv$period[2]
            df_dataNoNA = df_dataAll()[!is.na(df_dataAll()$Value),]
            
            df_Start = summarise(group_by(df_dataNoNA, Code),
                                 Start=min(Date, na.rm=TRUE))
            StartData = df_Start$Start
            df_End = summarise(group_by(df_dataNoNA, Code),
                               End=max(Date, na.rm=TRUE))            
            EndData = df_End$End
            CodeData = df_Start$Code

            CodeData[EndData <= Start | End <= StartData]
            
        } else {
            c()
        }
    })

    invalidCode = reactive({
        if (!is.null(df_dataAll())) {
            Start = rv$period[1]
            End = rv$period[2]
            df_dataNoNA = df_dataAll()[!is.na(df_dataAll()$Value),]
            df_dataNoNA = df_dataNoNA[Start <= df_dataNoNA$Date
                                      & df_dataNoNA$Date <= End,]
            
            df_Period = summarise(group_by(df_dataNoNA, Code),
                                  Period=length(Value))
            PeriodData = df_Period$Period/365.25
            CodeData = df_Period$Code

            CodeData[PeriodData < analyseMinYear]
            
        } else {
            c()
        }
    })

    
    badCode = reactive({
        badCode = c(missCode(), invalidCode())
        badCode[!duplicated(badCode)]
    })

### 2.6. Trend plot __________________________________________________
    observeEvent(input$map_marker_click, {

        if (rv$polyMode == 'false' & !rv$clickMode & !rv$dlClickMode) {
        
            if (!is.null(input$map_marker_click) & !is.null(rv$codeClick)) {
                if (input$map_marker_click$id == rv$codeClick) {

                    map = leafletProxy("map")
                    map = fitBounds(map,
                                    lng1=defaultLimits()$east,
                                    lat1=defaultLimits()$south,
                                    lng2=defaultLimits()$west,
                                    lat2=defaultLimits()$north,
                                    options=list(padding=c(20, 20)))
                    
                    rv$codeClick = NULL
                    hide(id='plot_panel')
                    
                } else {
                    rv$codeClick = input$map_marker_click$id
                }
            } else {
                rv$codeClick = input$map_marker_click$id
            }
        }
    })

    observeEvent(rv$codeClick, {
        Lon = df_meta()$lon[df_meta()$Code == rv$codeClick]
        Lat = df_meta()$lat[df_meta()$Code == rv$codeClick]
        names(Lon) = NULL
        names(Lat) = NULL
        
        map = leafletProxy("map")
        map = fitBounds(map,
                        lng1=Lon+1,
                        lat1=Lat+1,
                        lng2=Lon-1,
                        lat2=Lat-2,
                        options=list(padding=c(20, 20)))
    })

    observeEvent({
        rv$codeClick
        rv$period
        rv$var
        rv$width
    }, {
        
        if (rv$polyMode == 'false' & !rv$clickMode & !rv$dlClickMode & !is.null(rv$codeClick)) {
            
            showOnly(id='plot_panel', c(IdList_panel, 'plot_panel'))
            
            name = df_meta()$nom[df_meta()$Code == rv$codeClick]

            df_data_code = df_data()[df_data()$Code == rv$codeClick,]
            maxQ_win = max(df_data_code$Value, na.rm=TRUE)*1.1            
            df_XEx_code = rv$df_XEx[rv$df_XEx$Code == rv$codeClick,]
            df_Xtrend_code = rv$df_Xtrend[rv$df_Xtrend$Code == rv$codeClick,]
            color = rv$fillList[CodeAll() == rv$codeClick]
            switchColor = switch_colorLabel(color)
            
            output$trend_plot = plotly::renderPlotly({
                
                validate(need(!is.null(rv$codeClick), message=FALSE))
                
                fig1 = plotly::plot_ly()

                x = df_data_code$Date
                event = Var$event[Var$var == rv$var]
                if (event == "Étiage") {
                    y = sqrt(df_data_code$Value)
                    varLabel = "&#8730;Q"
                    unitLabel = " [m<sup>3/2</sup>.s<sup>-1/2</sup>]"
                } else {
                    y = df_data_code$Value
                    varLabel = "Q"
                    unitLabel = " [m<sup>3</sup>.s<sup>-1</sup>]"
                }
                    
                fig1 = plotly::add_trace(
                                  fig1,
                                  type="scatter",
                                  mode="lines",
                                  x=x,
                                  y=y,
                                  line=list(color=grey20COL, width=0.85),
                                  xhoverformat="%d/%m/%Y",
                                  hovertemplate = paste0(
                                      word("plot.day"),
                                      " ", "%{x}<br>",
                                      "<b>", varLabel, "</b> %{y}",
                                      unitLabel,
                                      "<extra></extra>"),
                                  hoverlabel=list(bgcolor=color,
                                                  font=list(size=12),
                                                  bordercolor="white"))


                df_data_codeLIM = df_data_code
                minDate = min(df_data_code$Date)
                maxDate = max(df_data_code$Date)
                
                if (minDate > rv$period[1]) {
                    NAadd = seq.Date(rv$period[1],
                                     minDate-1,
                                     "day")
                    nNAadd = length(NAadd)
                    df_data_codeLIM =
                        bind_rows(tibble(Date=NAadd,
                                         Value=rep(NA, nNAadd),
                                         Code=rep(rv$codeClick, nNAadd)),
                                  df_data_codeLIM)
                }
                
                if (maxDate < rv$period[2]) {
                    NAadd = seq.Date(maxDate+1,
                                     rv$period[2],
                                     "day")
                    nNAadd = length(NAadd)
                    df_data_codeLIM =
                        bind_rows(df_data_codeLIM,
                                  tibble(Date=NAadd,
                                         Value=rep(NA, nNAadd),
                                         Code=rep(rv$codeClick, nNAadd)))
                }
                
                # Extract NA data
                NAdate = df_data_codeLIM$Date[is.na(df_data_codeLIM$Value)]
                # Get the difference between each point of date data
                # without NA
                dNAdate = diff(NAdate)
                # If difference of day is not 1 then
                # it is TRUE for the beginning of each missing data period 
                NAdate_Down = NAdate[append(Inf, dNAdate) != 1]
                # If difference of day is not 1 then
                # it is TRUE for the ending of each missing data period 
                NAdate_Up = NAdate[append(dNAdate, Inf) != 1]
                
                nMiss = length(NAdate_Up)
                Ymin = rep(0, nMiss)
                Ymax = rep(maxQ_win, nMiss)

                lenMiss = NAdate_Up - NAdate_Down + 1
                
                for (i in 1:nMiss) {
                    fig1 = plotly::add_trace(
                                       fig1,
                                       type="scatter",
                                       mode="lines",
                                       x=c(NAdate_Down[i], NAdate_Down[i],
                                           NAdate_Up[i], NAdate_Up[i],
                                           NAdate_Down[i]),
                                       y=c(Ymin[i], Ymax[i],
                                           Ymax[i], Ymin[i],
                                           Ymin[i]),
                                       fill="toself",
                                       opacity=0.4,
                                       fillcolor=lightCyanCOL,
                                       line=list(width=0),
                                       text=paste0(
                                           "<b>",
                                           lenMiss[i],
                                           "</b>", " ",
                                           word("plot.miss")),
                                       hoverinfo="text",
                                       hoveron="fills",
                                       hoverlabel=
                                           list(bgcolor=lightCyanCOL,
                                                font=list(color="white",
                                                          size=12),
                                                bordercolor="white"))
                }
                
                # Gets the p value
                pVal = df_Xtrend_code$p

                if (pVal <= input$alpha_choice) {
                    colorLine = color
                    colorLabel = color
                } else {
                    colorLine = 'grey85'
                    colorLabel = 'grey85'
                }

                trendLabel = get_trendLabel(code=rv$codeClick,
                                            df_XEx=rv$df_XEx,
                                            df_Xtrend=rv$df_Xtrend,
                                            unit=rv$unit,
                                            space=TRUE)

                fig1 = plotly::add_annotations(
                                   fig1,
                                   x=0.01,
                                   y=1.01,
                                   xref="paper",
                                   yref="paper",
                                   text=trendLabel,
                                   showarrow=FALSE,
                                   xanchor='left',
                                   yanchor='bottom',
                                   font=list(color=switchColor,
                                             size=12))

                fig1 = plotly::add_annotations(
                                   fig1,
                                   x=0.01,
                                   y=1.29,
                                   xref="paper",
                                   yref="paper",
                                   text=paste0("<b>",
                                               rv$codeClick,
                                               "</b> - ",
                                               name),
                                   showarrow=FALSE,
                                   xanchor='left',
                                   yanchor='bottom',
                                   font=list(color=INRAECyanCOL,
                                             size=12))
                
                fig1 = plotly::layout(
                                   fig1,
                                   separators='. ',

                                   yaxis=list(
                                       range=c(0, maxQ_win),
                                       title=list(
                                           text=paste0(
                                               "<b>", varLabel, "</b>",
                                               unitLabel),
                                           font=list(color=grey20COL)),
                                       gridcolor=grey85COL,
                                       gridwidth=0.6,
                                       ticks="outside",
                                       tickcolor=grey75COL,
                                       tickfont=list(color=grey40COL),
                                       showline=TRUE,
                                       linewidth=2,
                                       linecolor=grey85COL,
                                       zerolinecolor=grey85COL,
                                       zerolinewidth=0.6,
                                       mirror=TRUE,
                                       fixedrange=TRUE),

                                   autosize=FALSE,
                                   plot_bgcolor=grey97COL,
                                   paper_bgcolor='transparent',
                                   showlegend=FALSE)

                fig1 = plotly::config(
                                   fig1,
                                   locale=word("plotly.language"),
                                   displaylogo=FALSE,
                                   toImageButtonOptions =
                                       list(format="svg"),
                                   modeBarButtonsToRemove =
                                       list("lasso2d",
                                            "select2d",
                                            "drawline",
                                            "zoom2d",
                                            "drawrect",
                                            "autoScale2d",
                                            "hoverCompareCartesian",
                                            "hoverClosestCartesian")
                               )     
                

                DateNoNA = df_XEx_code$Date[!is.na(df_XEx_code$Value)]
                abs = c(min(DateNoNA), max(DateNoNA))
                # Convert the number of day to the unit of the period
                abs_num = as.numeric(abs) / 365.25
                # Compute the y of the trend
                if (rv$unit == 'hm^{3}' | rv$unit == 'm^{3}.s^{-1}'| rv$unit == 'jour.an^{-1}' | rv$unit == 'jour') {
                    ord = abs_num * df_Xtrend_code$trend +
                        df_Xtrend_code$intercept
                } else if (rv$unit == "jour de l'année") {
                    ord = as.Date(abs_num * df_Xtrend_code$trend +
                        df_Xtrend_code$intercept, origin="1970-01-01")
                }

                x = df_XEx_code$Date
                if (rv$unit == 'hm^{3}' | rv$unit == 'm^{3}.s^{-1}'| rv$unit == 'jour.an^{-1}' | rv$unit == 'jour') {
                    y = df_XEx_code$Value
                    yhoverformat = '.3r'
                    unitLabel = rv$unit
                    unitLabel = gsub('[/^][/{]', '<sup>', unitLabel)
                    unitLabel = gsub('[/}]', '</sup>', unitLabel)
                    unitLabel = paste0(" [", unitLabel, "]<br>")
                } else if (rv$unit == "jour de l'année") {
                    y = as.Date(df_XEx_code$Value, origin="1970-01-01")
                    yhoverformat = "%d %b"
                    unitLabel = ""
                }
                if (is.null(rv$proba)) {
                    varLabel = Var$varHTML[Var$var == rv$var]
                } else {
                    varLabel = gsub('p', gsub("%", "", rv$proba),
                               Var$varHTML[Var$var == rv$var])
                }

                fig2 = plotly::plot_ly()
                
                fig2 = plotly::add_trace(
                                  fig2,
                                  type="scatter",
                                  mode="markers",
                                  x=x,
                                  y=y,
                                  marker=list(color=grey50COL),
                                  xhoverformat="%Y",
                                  yhoverformat=yhoverformat,
                                  hovertemplate = paste0(
                                      "année %{x}<br>",
                                      "<b>", varLabel, "</b> %{y}",
                                      unitLabel,
                                      "<extra></extra>"),
                                  hoverlabel=list(bgcolor=color,
                                                  font=list(size=12),
                                                  bordercolor="white"))

                fig2 = plotly::add_trace(
                                  fig2,
                                  type="scatter",
                                  mode="markers+lines",
                                  x=abs,
                                  y=ord,
                                  marker=list(color='white', size=6),
                                  line=list(color='white', width=6),
                                  hoverinfo="none")
                
                fig2 = plotly::add_trace(
                                  fig2,
                                  type="scatter",
                                  mode="markers+lines",
                                  x=abs,
                                  y=ord,
                                  marker=list(color=color, size=3),
                                  line=list(color=color, width=3),
                                  hoverinfo="none")
                
                unitLabel = rv$unit
                unitLabel = gsub('[/^][/{]', '<sup>', unitLabel)
                unitLabel = gsub('[/}]', '</sup>', unitLabel)
                unitLabel = paste0("[", unitLabel, "]<br>")
                title = paste0("<b> ", varLabel, "</b>",
                               " ", unitLabel)

                fig2 = plotly::layout(
                                   fig2,
                                   separators='. ',
                                   
                                   yaxis=list(
                                       title=list(
                                           text=title,
                                           font=list(color=grey20COL)),
                                       showgrid=FALSE,
                                       ticks="outside",
                                       tickcolor=grey75COL,
                                       tickfont=list(color=grey40COL),
                                       showline=TRUE,
                                       linewidth=2,
                                       linecolor=grey85COL,
                                       zerolinecolor="transparent",
                                       mirror=TRUE,
                                       fixedrange=TRUE),
                                   
                                   autosize=FALSE,
                                   plot_bgcolor=grey97COL,
                                   paper_bgcolor='transparent',
                                   showlegend=FALSE)

                if (rv$unit == "jour de l'année") {
                    fig2 = plotly::layout(
                                       fig2,
                                       yaxis=list(tickformat="%b"))
                }

                fig2 = plotly::config(
                                   fig2,
                                   locale=word("plotly.language"),
                                   displaylogo=FALSE,
                                   toImageButtonOptions =
                                       list(format="svg"),
                                   modeBarButtonsToRemove =
                                       list("lasso2d",
                                            "select2d",
                                            "drawline",
                                            "zoom2d",
                                            "drawrect",
                                            "autoScale2d",
                                            "hoverCompareCartesian",
                                            "hoverClosestCartesian")
                               )

                fig = plotly::subplot(fig1, fig2, nrows=2,
                                      heights=c(1/3, 2/3),
                                      titleY=TRUE,
                                      shareX=TRUE,
                                      margin=0.025)

                plotWidth = 480
                shift = 40
                if (plotWidth < rv$width - shift) {
                    width = plotWidth
                } else {
                    width = rv$width-shift
                }

                fig  = plotly::layout(fig,
                                      autosize=FALSE,
                                      width=width,
                                      height=230,
                                      
                                      xaxis=list(range=rv$period,
                                                 showgrid=FALSE,
                                                 ticks="outside",
                                                 tickcolor=grey75COL,
                                                 tickfont=
                                                     list(color=grey40COL),
                                                 showline=TRUE,
                                                 linewidth=2,
                                                 linecolor=grey85COL,
                                                 showticklabels=TRUE,
                                                 mirror="all"),
                                      
                                      margin=list(l=0,
                                                  r=12,
                                                  b=0,
                                                  t=32,
                                                  pad=0))
                                
                fig = plotly::config(
                                  fig,
                                  locale=word("plotly.language"),
                                  displaylogo=FALSE,
                                  toImageButtonOptions =
                                      list(format="svg"),
                                  modeBarButtonsToRemove =
                                      list("lasso2d",
                                           "select2d",
                                           "drawline",
                                           "zoom2d",
                                           "drawrect",
                                           "autoScale2d",
                                           "hoverCompareCartesian",
                                           "hoverClosestCartesian")
                              )
                fig
            })
        }
    })

    observeEvent(input$closePlot_button, {
        map = leafletProxy("map")
        map = fitBounds(map,
                        lng1=defaultLimits()$east,
                        lat1=defaultLimits()$south,
                        lng2=defaultLimits()$west,
                        lat2=defaultLimits()$north,
                        options=list(padding=c(20, 20)))
        
        rv$codeClick = NULL
        hide(id='plot_panel')
    })
    

## 3. CUSTOMIZATION __________________________________________________
    observeEvent(input$theme_button, {
        toggleOnly(id="theme_panel")
        deselect_mode(session, rv)
    })

    observeEvent(input$closeSettings_button, {
        hide(id='theme_panel')
        showElement(id='ana_panel')
    })
    
### 3.2. Palette _____________________________________________________
    observeEvent({
        input$colorbar_choice
        rv$df_Xtrend
    }, {        
        if (input$colorbar_choice == 'show' & !is.null(rv$df_Xtrend)) {
            showElement(id="colorbar_panel")
        } else if (input$colorbar_choice == 'none' | is.null(rv$df_Xtrend)) {
            hide(id="colorbar_panel")
        }
    })

    observeEvent({
        input$colorbar_choice
        rv$minValue
        rv$maxValue
        rv$df_value
    }, {
        
        if (input$colorbar_choice == 'show' & !is.null(rv$df_Xtrend)) {
            output$colorbar_plot = plotly::renderPlotly({
                
                res = compute_colorBin(min=rv$minValue,
                                       max=rv$maxValue,
                                       Palette=Palette,
                                       colorStep=colorStep,
                                       reverse=rv$reverse)

                bin = res$bin
                upBin = res$upBin
                Y1 = upBin / max(upBin[is.finite(upBin)])
                dY = mean(diff(Y1[is.finite(Y1)]))
                Y1[Y1 == Inf] = 1 + dY
                
                lowBin = res$lowBin
                Y0 = lowBin / max(lowBin[is.finite(lowBin)])
                Y0[Y0 == -Inf] = -1 - dY

                PaletteColors = res$Palette
                X0 = rep(0, colorStep)
                X1 = rep(1, colorStep)
                
                # Computes the histogram of values
                res = hist(rv$df_valueSample$value,
                           breaks=c(-Inf, bin, Inf),
                           plot=FALSE)
                # Extracts the number of counts per cells
                counts = res$counts
                
                fig = plotly::plotly_empty(width=62, height=260)
                
                for (i in 2:(colorStep-1)) {
                    fig = plotly::add_trace(
                                      fig,
                                      type="scatter",
                                      mode="lines",
                                      x=c(X0[i], X0[i], X1[i], X1[i], X0[i]),
                                      y=c(Y0[i], Y1[i], Y1[i], Y0[i], Y0[i]),
                                      fill="toself",
                                      fillcolor=PaletteColors[i],
                                      line=list(width=0),
                                      text=paste0("<b>",
                                                  counts[i],
                                                  "</b>",
                                                  "<br>stations"),
                                      hoverinfo="text",
                                      hoveron="fills",
                                      hoverlabel=list(bgcolor=counts[i],
                                                      font=list(color="white",
                                                                size=12),
                                                      bordercolor="white"))
                }
                
                fig = plotly::layout(
                                  fig,
                                  autosize=FALSE,
                                  xaxis=list(range=c(-1.51, 3.4),
                                             showticklabels=FALSE,
                                             fixedrange=TRUE),
                                  yaxis=list(range=c(-1-dY*2/3, 1+dY*2/3),
                                             showticklabels=FALSE,
                                             fixedrange=TRUE),
                                  plot_bgcolor='transparent',
                                  paper_bgcolor='transparent',
                                  showlegend=FALSE)
                
                fig = plotly::add_trace(
                                  fig,
                                  type="scatter",
                                  mode="lines",
                                  x=c(0, 1, 0.5, 0),
                                  y=c(1, 1, 1+dY*2/3, 1),
                                  fill="toself",
                                  fillcolor=PaletteColors[colorStep],
                                  line=list(width=0),
                                  text=paste0("<b>",
                                              counts[colorStep],
                                              "</b>",
                                              "<br>stations"),
                                  hoverinfo="text",
                                  hoveron="fills",
                                  hoverlabel=list(bgcolor=counts[colorStep],
                                                  font=list(size=12),
                                                  bordercolor="white"))
                
                fig = plotly::add_trace(
                                  fig,
                                  type="scatter",
                                  mode="lines",
                                  x=c(0, 1, 0.5, 0),
                                  y=c(-1, -1, -1-dY*2/3, -1),
                                  fill="toself",
                                  fillcolor=PaletteColors[1],
                                  line=list(width=0),
                                  text=paste0("<b>",
                                              counts[1],
                                              "</b>",
                                              "<br>stations"),
                                  hoverinfo="text",
                                  hoveron="fills",
                                  hoverlabel=list(bgcolor=counts[1],
                                                  font=list(size=12),
                                                  bordercolor="white"))

                Xlab = rep(1.2, colorStep)
                Ylab = bin / max(bin)

                ncharLim = 4
                if (rv$unit == 'hm^{3}' | rv$unit == 'm^{3}.s^{-1}') {                    
                    labelRaw = bin*100
                } else if (rv$unit == 'jour.an^{-1}' | rv$unit == 'jour' | rv$unit == "jour de l'année") {
                    labelRaw = bin
                }
                
                if (get_power(max(labelRaw)) < 0) {
                    power = get_power(min(labelRaw))
                    labelRaw = labelRaw * 10^(-power)
                    powerLabel = paste0("x<b>10<sup>",
                                        power,
                                        "</sup></b>")
                    fig = plotly::add_annotations(
                                      fig,
                                      x=0.95,
                                      y=-1-dY*2/3,
                                      text=powerLabel,
                                      showarrow=FALSE,
                                      xanchor='left',
                                      font=list(color=grey65COL,
                                                size=12.5))

                    fig = plotly::layout(
                                      fig,
                                      margin=list(l=0,
                                                  r=0,
                                                  b=6,
                                                  t=0,
                                                  pad=0))
                } else {
                    fig = plotly::layout(
                                      fig,
                                      margin=list(l=0,
                                                  r=0,
                                                  b=3,
                                                  t=3,
                                                  pad=0))
                }
                
                label2 = signif(labelRaw, 2)
                label2[label2 >= 0] = paste0(" ", label2[label2 >= 0])
                label1 = signif(labelRaw, 1)
                label1[label1 >= 0] = paste0(" ", label1[label1 >= 0])
                label = label2        
                label[nchar(label2) > ncharLim] = label1[nchar(label2) > ncharLim]
                label = paste0("<b>", label, "</b>")
                
                fig = plotly::add_annotations(
                                  fig,
                                  x=Xlab,
                                  y=Ylab,
                                  text=label,
                                  showarrow=FALSE,
                                  xanchor='left',
                                  font=list(color=grey40COL,
                                            size=12))

                unit = rv$unit
                unit = gsub("^jour$|^jour de l[/']année$",
                            paste0(word("unit.day"),
                                   " ", word("unit.by"), " ",
                                   word("unit.year")),
                            unit)
                unit =
                    gsub('^m[/^][/{]3[/}][.]s[/^][/{]-1[/}]$|^hm[/^][/{]3[/}]$',
                         paste0("%", " ", word("unit.by"), " ",
                                word("unit.year")),
                         unit)
                unit = gsub('^jour[.]an[/^][/{]-1[/}]$',
                            paste0(word("unit.day"), " ",
                                   word("unit.by"), " ",
                                   word("unit.year"), "<sup>2</sup>"),
                            unit)
                title = paste0("<b>", word("cb.title"), "</b>",
                               " ", unit)
                
                fig = plotly::add_annotations(
                                  fig,
                                  x=-0.1,
                                  y=0,
                                  text=title,
                                  textangle=-90,
                                  showarrow=FALSE,
                                  xanchor='right',
                                  yanchor='center',
                                  font=list(color=grey50COL,
                                            size=13.5))
                
                fig = plotly::config(
                                  fig,
                                  displaylogo=FALSE,
                                  displayModeBar=FALSE,
                                  doubleClick=FALSE)                
                fig  
            })
        }
    })

### 3.3. Resume panel ________________________________________________
    observeEvent({
        input$resume_choice
        rv$df_Xtrend
    }, {
        if (input$resume_choice == 'show' & !is.null(rv$df_Xtrend)) {
            showElement(id="resume_panel")
        } else if (input$resume_choice == 'none') {
            hide(id="resume_panel")
        }
    })

    
## 4. INFO ___________________________________________________________
    observeEvent(input$info_button, {
        toggleOnly(id="info_panel")
        deselect_mode(session, rv)
    })

    
## 5. SAVE ___________________________________________________________
### 5.1. Screenshot __________________________________________________
    observeEvent(input$photo_button, {
        hide(id="zoom_panelButton")
        hide(id="ana_panelButton")
        hide(id="theme_panelButton")
        hide(id="photo_panelButton")
        hide(id="download_panelButton")
        hide(id="help_panelButton")
        hide(id="actualise_panelButton")
        
        hideAll()
        
        deselect_mode(session, rv)
        rv$photoMode = TRUE
    })

    observeEvent(input$map_click, {
        if (rv$polyMode == 'false' & !rv$clickMode & !rv$dlClickMode & rv$photoMode) {
            showElement(id="zoom_panelButton")
            showElement(id="ana_panelButton")
            showElement(id="theme_panelButton")
            showElement(id="photo_panelButton")
            showElement(id="download_panelButton")
            showElement(id="help_panelButton")
            # showElement(id="actualise_panelButton")
            rv$photoMode = FALSE
        }
    })
    

### 5.2. Download ____________________________________________________
    observeEvent(input$download_button, {
        toggleOnly(id="download_bar")
        deselect_mode(session, rv)
    })

    observe({
        if (!is.null(input$dlClick_select)) {
            hide(id='ana_panel')
            hide(id='theme_panel')
            hide(id='info_panel')
            hide(id='photo_bar')
            hide(id='download_bar')
            hide(id='click_bar')
            hide(id='poly_bar')
            showElement(id='dlClick_bar')
            rv$dlClickMode = TRUE
        } else {
            if (rv$dlClickMode) {
                deselect_mode(session, rv)
                hide(id='dlClick_bar')
                showElement(id='download_bar')
            }
        }
    })

    observeEvent(input$dlSelec_button, {
        outdir = file.path(computer_data_path, "zip")        
        if (!(file.exists(outdir))) {
            dir.create(outdir)
        }
        outfile = "fiches_stations.zip"
        outpath = file.path(outdir, outfile)
        
        files = file.path(computer_data_path, "pdf",
                          paste0(CodeSample(), ".pdf"))
        zip(zipfile=outpath, files=files, flags = '-r9Xj')

        output$downloadData = downloadHandler(
            filename = function () {
                outfile
            },
            content = function (file) {
                from = outpath
                file.copy(from, file)
            }
        )
        jsinject = "setTimeout(function()
                        {window.open($('#downloadData')
                        .attr('href'))}, 100);"
        session$sendCustomMessage(type='jsCode',
                                  list(value=jsinject))  
    })

    observeEvent(input$dlAll_button, {
        outdir = file.path(computer_data_path, "zip")        
        if (!(file.exists(outdir))) {
            dir.create(outdir)
        }
        outfile = "fiches_stations_ALL.zip"
        outpath = file.path(outdir, outfile)

        if (!(file.exists(outpath))) {
            files = dir(file.path(computer_data_path, "pdf") ,
                        full.names=TRUE)            
            zip(zipfile=outpath, files=files, flags = '-r9Xj')
        }

        output$downloadData = downloadHandler(
            filename = function () {
                outfile
            },
            content = function (file) {
                from = outpath
                file.copy(from, file)
            }
        )
        jsinject = "setTimeout(function()
                        {window.open($('#downloadData')
                        .attr('href'))}, 100);"
        session$sendCustomMessage(type='jsCode',
                                  list(value=jsinject))
    })


    observeEvent(input$map_marker_click, {
        if (rv$polyMode == 'false' & !rv$clickMode & rv$dlClickMode & !rv$photoMode) {
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

    observeEvent(input$dlClickOk_button, {
        deselect_mode(session, rv)
        hide(id='dlClick_bar')
        showElement(id='download_bar')
    })

## 6. HELP ___________________________________________________________
    observeEvent(input$help_button, {
        rv$helpPage = 1
        rv$helpPage_save = 0
        hide(id='help_panelButton')
        showElement(id='closeHelp_panelButton')

        hideAll()
        deselect_mode(session, rv)
        
        maskAll()
        showElement(id='blur_panel')
        
        showElement(id='focusZoom_panelButton')
        showElement(id='actualise_panelButton')
        
        showElement(id='before_panelButton')
        show_page(n=1, N=N_helpPage)
        showElement(id='next_panelButton')
        
    })

    observeEvent(input$before_button, {
        if (rv$helpPage > 1) {
            show_page(n=rv$helpPage - 1, N=N_helpPage)
            rv$helpPage = rv$helpPage - 1
        }
    })
    
    observePage(input, rv, n=1, N=N_helpPage)
    observePage(input, rv, n=2, N=N_helpPage)
    observePage(input, rv, n=3, N=N_helpPage)
    observePage(input, rv, n=4, N=N_helpPage)
    observePage(input, rv, n=5, N=N_helpPage)
    observePage(input, rv, n=6, N=N_helpPage)
    observePage(input, rv, n=7, N=N_helpPage)
    observePage(input, rv, n=8, N=N_helpPage)
    observePage(input, rv, n=9, N=N_helpPage)
    observePage(input, rv, n=10, N=N_helpPage)
    observePage(input, rv, n=11, N=N_helpPage)
    observePage(input, rv, n=12, N=N_helpPage)
    observePage(input, rv, n=13, N=N_helpPage)
    observePage(input, rv, n=14, N=N_helpPage)
    observePage(input, rv, n=15, N=N_helpPage)

    observeEvent({
        rv$helpPage
        rv$width
    }, {
        if (!is.null(rv$helpPage)) {

            if (rv$helpPage == 1 | rv$helpPage == 2 | rv$helpPage == 3) {
                hideAll()
                maskAll()
            }

            width_lim = 1260
            if (rv$width <= width_lim) {
                hideAll()
            }
            
            if (rv$helpPage == 4) {
                hideAll()
                maskOnly(id="maskZoom_panelButton")
                rv$CodeSample = CodeAll()[substr(CodeAll(), 1, 1) == "O"]
            } else {
                rv$CodeSample = CodeAll()
            }

            if (rv$helpPage == 5) {
                if (rv$width > width_lim) {
                    showOnly(id=c("ana_panel", "poly_bar"))
                }
                maskOnly(id="maskAna_panelButton")
            }
                
            if (rv$helpPage == 6 | rv$helpPage == 7 | rv$helpPage == 8) {
                if (rv$width > width_lim) {
                    showOnly(id="ana_panel")
                }
                maskOnly(id="maskAna_panelButton")
            }

            if (rv$helpPage == 10) {
                if (rv$width > width_lim) {
                    showOnly(id="ana_panel")
                }
                maskOnly(id=c("maskAna_panelButton",
                              "maskActualise_panelButton"))
            }

            if (rv$helpPage == 11) {
                if (rv$width > width_lim) {
                    showOnly(id="theme_panel")
                }
                maskOnly(id="")
            }

            if (rv$helpPage == 12) {
                if (rv$width > width_lim) {
                    showOnly(id="theme_panel")
                }
                maskOnly(id="")
            }

            if (rv$helpPage == 13) {
                if (rv$width > width_lim) {
                    showOnly(id="photo_bar")
                }
                maskOnly(id="maskPhoto_panelButton")
            }

            if (rv$helpPage == 14) {
                if (rv$width > width_lim) {
                    showOnly(id="download_bar")
                }
                maskOnly(id="maskDownload_panelButton")
            }

            if (rv$helpPage == 15) {
                if (rv$width > width_lim) {
                    showOnly(id="info_panel")
                }
                maskOnly(id="maskInfo_panelButton")
            }
        }
    })

    observeEvent(input$next_button, {
        if (rv$helpPage < N_helpPage) {
            show_page(n=rv$helpPage + 1, N=N_helpPage)
            rv$helpPage = rv$helpPage + 1
        }
    })

    observeEvent(input$closeHelp_button, {
        rv$helpPage = NULL
        rv$helpPage_save = NULL

        hideAll()
        
        hide(id='focusZoom_panelButton')
        hide(id='actualise_panelButton')
        
        demaskAll()

        hide(id='before_panelButton')
        hide_page(N=N_helpPage)
        hide(id='next_panelButton')
        hide(id='closeHelp_panelButton')     
        showElement(id='help_panelButton')

        hide(id='blur_panel')
    })

    
} 

