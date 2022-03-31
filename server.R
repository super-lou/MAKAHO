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
                    resources_path)
    })
    
    output$map = renderLeaflet({
        map = leaflet(options=leafletOptions(minZoom=minZoom,
                                             maxZoom=maxZoom,
                                             worldCopyJump=FALSE,
                                             zoomControl=FALSE,
                                             attributionControl=FALSE))
        map = setView(map,
                      centroids$longitude[centroids$country == country],
                      centroids$latitude[centroids$country == country],
                      6)
        
        map = addTiles(map,
                       urlTemplate=urlTile())
    })

### 1.2. Marker ______________________________________________________
    observeEvent({ ### /!\
        input$theme_choice
        input$signif_choice
        df_meta()
        fillList()
    }, {
        map = leafletProxy("map")
        
        alpha = as.numeric(sub("%", "", input$signif_choice)) / 100

        CodeSample = CodeSample()
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

        if (input$theme_choice != rv$theme_choice_save) {
            okCode = rep(TRUE, length(CodeAll()))
        } else {
            okCode = unlist(markerListAll$iconUrl) != rv$iconUrl_save
        }
        rv$theme_choice_save = input$theme_choice

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
    

### 2.2. Variable extration __________________________________________
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
        updateRadioGroupButtons(session, "proba_choice",
                                size="sm",
                                justified=TRUE,
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
        
    rv = reactiveValues(CodeSample=isolate(CodeAll()),
                        markerList_save=NULL,
                        CodeSample_save=isolate(CodeAll()),
                        Search_save=NULL,
                        polyCoord=NULL,
                        theme_choice_save=isolate(input$theme_choice))

    CodeSample = reactive({
        rv$CodeSample
    })
    CodeSample = debounce(CodeSample, 500)

#### 2.4.1. Map click ________________________________________________
    observeEvent(input$map_marker_click, {
        if (is.null(rv$polyCoord)) {
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

#### 2.4.2. Picker ___________________________________________________
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
        }
    }, suspended=TRUE)

#### 2.4.3. Polygone _________________________________________________
    observeEvent(input$poly_button, {
        hide(id='ana_panel')
        hide(id='theme_panel')
        hide(id='info_panel')
        showElement(id='poly_panel')
        rv$polyCoord = tibble()
    })

    observeEvent(input$map_click, {
        if (!is.null(rv$polyCoord)) {
            rv$polyCoord = bind_rows(rv$polyCoord,
                                     tibble(lng=input$map_click$lng,
                                            lat=input$map_click$lat))
            map = leafletProxy("map")
            map = clearShapes(map)
            map = addPolygons(map,
                              lng=rv$polyCoord$lng,
                              lat=rv$polyCoord$lat)            
        }
    })

    observeEvent(input$polyOk_button, {
        hide(id='poly_panel')
        
        station_coordinates = SpatialPointsDataFrame(
            df_meta()[c('lon', 'lat')],
            df_meta()['code'])

        # Transform them to an sp Polygon
        drawn_polygon = Polygon(as.matrix(rv$polyCoord))
        
        # Use over from the sp package to identify selected station
        selected_station = station_coordinates %over% SpatialPolygons(list(Polygons(list(drawn_polygon),"drawn_polygon")))
        
        rv$CodeSample = df_meta()$code[!is.na(selected_station)]

        map = leafletProxy("map")
        map = clearShapes(map)
        rv$polyCoord = NULL
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
            paste0("name:", df_meta()$nom),
            paste0("region:", df_meta()$region_hydro),
            paste0("regime:", df_meta()$regime_hydro),
            paste0("location:", meta_location()),
            paste0("river:", meta_river()),
            paste0("basin:", meta_basin())
        )
        htmlValues = c(
            paste0(df_meta()$nom,
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.name"),
                   '</i>'),
            paste0(df_meta()$region_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.region"),
                   '</i>'),
            paste0(df_meta()$regime_hydro,
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.regime"),
                   '</i>'),
            paste0(meta_location(),
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.location"),
                   '</i>'),
            paste0(meta_river(),
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.river"),
                   '</i>'),
            paste0(meta_basin(),
                   '<i style="font-size: 9pt; color: ',
                   grey70COL, '">&emsp;', word("a.search.basin"),
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
        
        CodeNom = df_meta()$code[df_meta()$nom %in% Search[searchType == "name"]]
        CodeRegion = df_meta()$code[df_meta()$region_hydro %in% Search[searchType == "region"]]
        CodeRegime = df_meta()$code[df_meta()$regime_hydro %in% Search[searchType == "regime"]]
        CodeLocation = df_meta()$code[meta_location() %in% Search[searchType == "location"]]
        CodeRiver = df_meta()$code[meta_river() %in% Search[searchType == "river"]]
        CodeBasin = df_meta()$code[meta_basin() %in% Search[searchType == "basin"]]

        CodeSample = levels(factor(c(CodeNom,
                                     CodeRegion,
                                     CodeRegime,
                                     CodeLocation,
                                     CodeRiver,
                                     CodeBasin)))
        rv$CodeSample = CodeSample
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
    df_trend = reactive({
        if (!is.null(df_XEx())) {
            Estimate.stats(data.extract=df_XEx(),
                           dep.option='AR1')
        } else {
            NULL
        }
    })

### 2.6. Color _______________________________________________________
    fillList = reactive({
        CodeSample = CodeSample()
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
    
    
## 4. INFO ___________________________________________________________
    observeEvent(input$info_button, {
        toggle(id='info_panel')
        hide(id='ana_panel')
        hide(id='theme_panel')
    })

    
   
} 

