# Copyright 2022-2023 Louis Héraut (louis.heraut@inrae.fr)*1,
#                     Éric Sauquet (eric.sauquet@inrae.fr)*1,
#                     Michel Lang (michel.lang@inrae.fr)*1,
#                     Jean-Philippe Vidal (jean-philippe.vidal@inrae.fr)*1,
#                     Benjamin Renard (benjamin.renard@inrae.fr)*1
#                     
# *1   INRAE, France
#
# This file is part of MAKAHO R shiny app.
#
# MAKAHO R shiny app is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MAKAHO R shiny app is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MAKAHO R shiny app.
# If not, see <https://www.gnu.org/licenses/>.


word = function (id) {
    w = dico[[language]][dico$id == id]
    return (w)
}

create_dico = function (dico_file, resources_path) {
    dico_path = file.path(resources_path, dico_file)
    dico = tibble(read.table(dico_path, header=TRUE, sep=";"))
    for (j in 1:ncol(dico)) {
        dico[j] = as.character(dico[[j]])
    }
    return (dico)
}


get_Var = function (dico, varProba) {
    OkEvent = as.vector(regexpr("^ana.var[0-9]$", dico[[1]])) != -1
    IdEvent = which(OkEvent)
    nbEvent = sum(as.numeric(OkEvent))

    Var = tibble()

    for (i in 1:nbEvent) {
        event = word(paste0("ana.var", i))
        
        OkNumVar = as.vector(regexpr(paste0("^ana.var", i,
                                            ".[0-9]$"), dico[[1]]))
        nbVar = sum(OkNumVar[OkNumVar == 1])        
        
        for (j in 1:nbVar) {
            var = word(paste0("ana.var", i, "." , j))

            varHTML = var
            if (grepl('[_]', var)) {
                varHTML = paste0("<span>", gsub('_', '<sub>', var), "</sub>", "</span>")
            }
            
            name = word(paste0("tt.ana.var", i, "." , j))
            
            if (grepl('^t.*', var) | grepl('^dt.*', var)) {
                type = 'saisonnalité'
            } else {
                type = 'sévérité'
            } ### /!\ attention si y'a d'autre type
            
            if (var %in% names(varProba)) {
                proba = list(varProba[[which(names(varProba) == var)]])
            } else {
                proba = NA
            }

            reverse = get_reverse(var)
            Var = bind_rows(Var, tibble(event=event,
                                        var=var,
                                        varHTML=varHTML,
                                        name=name,
                                        type=type,
                                        proba=proba,
                                        reverse=reverse))
        }
    } 
    return (Var)
}


get_Var2 = function (CARD_path, CARD_dir, check_varSub) {

    if (verbose) print("plot_trend")
    
    CARD_dirpath = file.path(CARD_path, CARD_dir)
    CARD_filepath = list.files(CARD_dirpath,
                               full.names=TRUE,
                               recursive=TRUE)
    nVar = length(CARD_filepath)
    Var = dplyr::tibble()
    
    for (CARD in CARD_filepath) {
        list_path = list.files(file.path(CARD_path,
                                         "__tools__"),
                               pattern='*.R$',
                               recursive=TRUE,
                               full.names=TRUE)
        for (path in list_path) {
            source(path, encoding='UTF-8')    
        }
        
        Process_default = sourceProcess(
            file.path(CARD_path, "__default__.R"))
        
        Process = sourceProcess(
            file.path(CARD),
            default=Process_default)

        principal = Process$P
        principal_names = names(principal)
        for (pp in 1:length(principal)) {
            assign(principal_names[pp], principal[[pp]])
        }

        CARD_var = var
        
        var = gsub("^[[:digit:]]+[_]", "",
                   gsub("[.]R", "", basename(CARD)))

        varHTML = var
        if (grepl('[_]', var)) {
            varHTML = paste0("<span>",
                             gsub('_', '<sub>', var),
                             "</sub>", "</span>")
        }
        
        if (any(sapply(check_varSub, grepl, var))) {
            id = which(sapply(check_varSub, grepl, var))
            
            if (grepl("(month)|(season)", var)) {
                to_rm = gsub("(month)|(season)", "",
                             var)
                sub = gsub(to_rm, "", CARD_var)

                Var = bind_rows(
                    Var,
                    dplyr::tibble(type=topic[1],
                                  event=topic[2],
                                  var=var,
                                  varHTML=varHTML,
                                  name=list(glose),
                                  sub=list(sub),
                                  reverse=reverse_palette))
                
            } else {
                sub = paste0(stringr::str_extract(var,
                                                  "[[:digit:]]+$"),
                             "%")
                var = gsub("[[:digit:]]+$", "p", var)
                var_regexp = paste0("^", var, "$")
                varHTML = var
                if (grepl('[_]', var)) {
                    varHTML = paste0("<span>",
                                     gsub('_', '<sub>', var),
                                     "</sub>", "</span>")
                }

                ok1 = grepl(var_regexp, Var$var)
                ok2 = Var$event == topic[2]
                if (identical(ok2, logical(0))) {
                    ok2 = FALSE
                }
                
                if (!any(ok1 & ok2)) {
                    Var = bind_rows(
                        Var,
                        dplyr::tibble(type=topic[1],
                                      event=topic[2],
                                      var=var,
                                      varHTML=varHTML,
                                      name=list(glose),
                                      sub=list(sub),
                                      reverse=reverse_palette))
                } else {
                    id2 = which(ok1 & ok2)
                    Var$name[[id2]] = c(Var$name[[id2]], glose)
                    Var$sub[[id2]] = c(Var$sub[[id2]], sub)
                }
            }
            
        } else {
            Var = bind_rows(
                Var,
                dplyr::tibble(type=topic[1],
                              event=topic[2],
                              var=var,
                              varHTML=varHTML,
                              name=list(glose),
                              sub=NA,
                              reverse=reverse_palette))
        }
    }
    
    return (Var) 
}


# get_Var(dico, varProba)


get_urlTile = function (theme, provider, theme_file, resources_path, token=NULL) {
    
    theme_path = file.path(resources_path, theme_file)
    urlTiles = as.character(read.table(file=theme_path,
                                       header=FALSE,
                                       quote='"')[[1]])
        
    OkProvider = grepl(provider, urlTiles, fixed=TRUE)
    urlTiles_provider = urlTiles[OkProvider]
    
    if (provider == "jawg") {
        if (theme == 'light') {
            themeUrl = 'light'
        } else if (theme == 'terrain') {
            themeUrl = 'terrain'
        } else if (theme == 'dark') {
            themeUrl = 'dark'
        }
    } else if (provider == "stadia") {
        if (theme == 'light') {
            themeUrl = "alidade_smooth/"
        } else if (theme == 'terrain') {
            themeUrl ="outdoors"
        } else if (theme == 'dark') {
            themeUrl = "alidade_smooth_dark/"
        }
    }

    OkTheme = grepl(themeUrl, urlTiles_provider, fixed=TRUE)
    urlTile = urlTiles_provider[OkTheme]
    
    if (provider == "jawg") {
        urlTile = sub("[{]accessToken[}]", token, urlTile)
    }
    return (urlTile)
}

# get_urlTile('light', 'stadia',
#             'theme.txt',
#             resources_path,
#             token=jawg_token)


create_iconLib = function (icon_dir, resources_path) {
    iconLib = icon_set(file.path(resources_path, icon_dir))#, icon_file))
    return (iconLib)
}

create_centroids = function (centroids_file, resources_path) {
    # Path of the list of centroids of every countries
    centroids_path = file.path(resources_path, centroids_file)
    
    centroids = tibble(read.table(centroids_path, header=TRUE,
                                  quote='', sep=";"))
    for (j in 1:ncol(centroids)) {
        if (is.factor(centroids[[j]])) {
            centroids[j] = as.character(centroids[[j]])
        }
    }
    return (centroids)
}

create_area = function (area_file, resources_path) {
    area_path = file.path(resources_path, area_file)
    area = tibble(read.table(area_path, header=TRUE,
                             quote='', sep=";"))
    area$country = as.character(area$country)
    area$area = as.double(area$area)
    return (area)
}

Button = function (inputId, label=NULL, icon_name=NULL,
                   width=NULL, tooltip=NULL, ...){

    if (is.null(tooltip)) {
        actionButton(inputId=inputId,
                     label=div(label,
                               style="float:right;
                                          padding-left:0.2rem;"),
                     icon=NULL,
                     width=width,
                     img(icon_name, align="right",
                         style="text-align: center;
                                display: flex; align-items: center;"),
                     ...)
    } else {
        div(class="Tooltip bunch",
            HTML(paste0(
                actionButton(inputId=inputId,
                             label=div(label,
                                       style="float:right;
                                          padding-left:0.2rem;"),
                             icon=NULL,
                             width=width,
                             img(icon_name, align="right",
                                 style="text-align: center;
                                        display: flex; align-items: center;"),
                             ...),
                '<span class="Tooltiptext">', tooltip, '</span>')))
    }
}

selectButton = function (inputId, label=NULL, icon_name=NULL,
                         class='', selected=FALSE, tooltip=NULL, ...){

    if (is.null(tooltip)) {
        div(class="Tooltip bunch",
            HTML(paste0(
                checkboxGroupButtons(
                    status=class,
                    inputId=inputId,
                    label=NULL,
                    choiceNames=
                        paste0(img(icon_name,
                                   align="right",
                                   style="text-align: center;
                                          display: flex; align-items: center;"),
                               label),
                    choiceValues=TRUE,
                    selected=selected,
                    ...),
                '<span class="Tooltiptext">', tooltip, '</span>')))
    } else {
        checkboxGroupButtons(
            status=class,
            inputId=inputId,
            label=NULL,
            choiceNames=
                paste0(img(icon_name,
                           align="right",
                           style="text-align: center;
                                  display: flex; align-items: center;"),
                       label),
            choiceValues=TRUE,
            selected=selected,
            ...)
    }
}

updateSelectButton = function (session, inputId, label=NULL,
                               icon_name=NULL, class='',
                               selected=FALSE, ...){

    if (is.null(icon_name) & is.null(label)) {
        choiceNames = NULL
        choiceValues = NULL
    } else {
        choiceNames = paste0(img(icon_name,
                                 align="right",
                                 style="text-align: center;
                                        display: flex; align-items: center;"),
                             label)
        choiceValues = TRUE
    }
    
    updateCheckboxGroupButtons(
        session=session,
        status=class,
        inputId=inputId,
        label=NULL,
        choiceNames=choiceNames,
        choiceValues=choiceValues,
        selected=selected,
        ...)
}

radioButton = function (class='', choiceIcons=NULL, choiceNames=NULL,
                        choiceValues=NULL, choiceTooltips=NULL, ...) {

    if (!is.null(choiceNames)) {
        choiceItems = choiceNames

        if (is.null(choiceValues)) {
            choiceValues = choiceNames
        }
        
    } else {
        choiceItems = replicate(max(length(choiceTooltips),
                                    length(choiceIcons)),
                                "", simplify=FALSE)
    }
    if (!is.null(choiceIcons)) {
        inter = lapply(choiceIcons, img, align="right",
                       style="text-align: center;
                              display: flex; align-items: center;")
        choiceItems = mapply(paste0, inter, choiceItems)
    }
    if (!is.null(choiceTooltips)) {
        choiceItems = lapply(paste0(choiceItems,
                                    '<span class="Tooltiptext">',
                                    choiceTooltips,
                                    '</span>'), HTML)
        choiceItems = lapply(choiceItems,
                             div, class="Tooltip bunch")
    }

    radioGroupButtons(
        status=class,
        label=NULL,
        choiceNames=choiceItems,
        choiceValues=choiceValues,
        ...)
}


updateRadioButton = function (session, class='', choiceIcons=NULL,
                              choiceNames=NULL, choiceValues=NULL,
                              choices=NULL,
                              choiceTooltips=NULL, ...) {

    if (!is.null(choiceNames)) {
        choiceItems = choiceNames

        if (is.null(choiceValues)) {
            choiceValues = choiceNames
        }
        
    } else {
        choiceItems = replicate(max(length(choiceTooltips),
                                    length(choiceIcons)),
                                "", simplify=FALSE)
    }
    
    if (!is.null(choiceIcons)) {
        inter = lapply(choiceIcons, img, align="right",
                       style="text-align: center;
                              display: flex; align-items: center;")
        choiceItems = mapply(paste0, inter, choiceItems)
    }
    if (!is.null(choiceTooltips)) {
        choiceItems = lapply(paste0(choiceItems,
                                    '<span class="Tooltiptext">',
                                    choiceTooltips,
                                    '</span>'), HTML)
        choiceItems = lapply(choiceItems,
                             div, class="Tooltip bunch")
    }

    if (!is.null(choices)) {
        updateRadioGroupButtons(
            session=session,
            status=class,
            label=NULL,
            choices=choices,
            ...)
    } else {
        updateRadioGroupButtons(
            session=session,
            status=class,
            label=NULL,
            choiceNames=choiceItems,
            choiceValues=choiceValues,
            ...) 
    }
}


Slider = function (class, modeText=FALSE, ...) {
    if (modeText) {
        div(class=class,
            sliderTextInput(...))
    } else {
        div(class=class,
            sliderInput(...))
    }
}
updateSlider = function (class, modeText=FALSE, ...) {
    if (modeText) {
        div(class=class,
            updateSliderTextInput(...))
    } else {
        div(class=class,
            updateSliderInput(...))
    }
}


page_circle = function (n, leftBase, widthHelp,
                        bottom, dh, tooltip=NULL) {
    hidden(
        fixedPanel(id=paste0("c", n,"_panelButton"),
                   left=paste0("calc(", leftBase,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dh*(n-1), "px)"),
                   bottom=bottom,
                   width="auto", height="auto",

                   hidden(
                       div(id=paste0("c", n,"U_panelButton"),
                           Button(class="Button-icon",
                                  inputId=paste0("c", n, "U_button"),
                                  label=NULL,
                                  icon_name=iconLib$circle_unchecked_white,
                                  tooltip=tooltip))
                   ),
                   hidden(
                       div(id=paste0("c", n,"C_panelButton"),
                           Button(class="Button-icon",
                                  inputId=paste0("c", n, "C_button"),
                                  label=NULL,
                                  icon_name=iconLib$circle_checked_white,
                                  tooltip=tooltip))
                   )
                   )
    )
}

show_page = function (n, N) {
    
    for (i in 1:N) {
        if (i == n) {
            showElement(id=paste0('help', i, '_panel'))
        } else {
            hide(id=paste0('help', i, '_panel'))
        }

        showElement(id=paste0('c', i, '_panelButton'))
        if (i <= n) {
            hide(id=paste0('c', i, 'U_panelButton'))
            showElement(id=paste0('c', i, 'C_panelButton'))
        } else {
            showElement(id=paste0('c', i, 'U_panelButton'))
            hide(id=paste0('c', i, 'C_panelButton'))
        }
    }
}

hide_page = function (N) {
    for (i in 1:N) {
        hide(id=paste0('help', i, '_panel'))
        hide(id=paste0('c', i, 'U_panelButton'))
        hide(id=paste0('c', i, 'C_panelButton'))
    }
}


observePage = function (input, rv, n, N) {
    observeEvent(input[[paste0("c", n ,"U_button")]], {
        rv$helpPage = n
        show_page(n=n, N=N)
    })    
    observeEvent(input[[paste0("c", n ,"C_button")]], {
        rv$helpPage = n
        show_page(n=n, N=N)
    })
}

IdList_mask = c("maskZoom_panelButton",
                "maskAna_panelButton",
                "maskActualise_panelButton",
                "maskInfo_panelButton",
                "maskPhoto_panelButton",
                "opacPhoto_panelButton",
                "maskDownload_panelButton")

maskAll = function (except=NULL, None=FALSE,
                    IdList=IdList_mask) {
    for (Id in IdList) {
        if (!(Id %in% except)) {
            showElement(id=Id)
        }
    }
}

demaskAll = function (except=NULL, None=FALSE,
                      IdList=IdList_mask) {
    for (Id in IdList) {
        if (!(Id %in% except)) {
            hide(id=Id)
        }
    }
}

maskOnly = function (id, IdList=IdList_mask) {
    for (Id in IdList) {
        if (Id %in% id) {
            hide(id=Id)
        } else {
            showElement(id=Id)
        }
    }
}

IdList_panel = c('ana_panel',
                 'theme_panel',
                 'info_panel',
                 'photo_bar',
                 'download_bar',
                 'click_bar',
                 'dlClick_bar',
                 'poly_bar')

hideAll = function (except=NULL, IdList=IdList_panel) {
    for (Id in IdList) {
        if (!(Id %in% except)) {
            hide(id=Id)
        }
    }
}

showOnly = function (id, IdList=IdList_panel) {
    for (Id in IdList) {
        if (Id %in% id) {
            showElement(id=Id)
        } else {
            hide(id=Id)
        }
    }
}

toggleOnly = function (id, IdList=IdList_panel) {
    for (Id in IdList) {
        if (Id %in% id) {
            toggle(id=Id)
        } else {
            hide(id=Id)
        }
    }
}


deselect_mode = function (session, rv) {
    updateSelectButton(
        session=session,
        class="selectButton",
        inputId="click_select",
        selected=FALSE)
    rv$clickMode = FALSE

    updateSelectButton(
        session=session,
        class="selectButton",
        inputId="poly_select",
        selected=FALSE)
    map = leafletProxy("map")
    map = clearShapes(map)
    rv$polyMode = 'false'
    rv$polyCoord = NULL

    updateSelectButton(
        session=session,
        class="selectButton",
        inputId="dlClick_select",
        selected=FALSE)
    rv$dlClickMode = FALSE
}


# read_FST = function (resdir, filename, filedir='fst') {
#     outfile = file.path(resdir, filedir, filename)
#     df = tibble(fst::read_fst(outfile))
#     return (df)
# }
# data = read_FST(computer_data_path, 'QIXAEx_01.fst', filedir='fst')
# meta = read_FST(computer_data_path, 'meta.fst', filedir='fst')


get_trendExtremesMOD = function (rv,
                                 data, df_trend, unit,
                                 minXprob=0, maxXprob=1,
                                 CodeSample=NULL) {
    
    if (unit == 'hm^{3}' | unit == 'm^{3}.s^{-1}') {
        df_mean =
            summarise(group_by(data, Code),
                      mean=mean(get(rv$var), na.rm=TRUE))

        df_join = full_join(df_trend, df_mean, by="Code")
        value = df_join$a / df_join$mean
        Code = df_join$Code
    } else {
        value = df_trend$a
        Code = df_trend$Code
    }

    if (!is.null(CodeSample)) {
        valueSample = value[Code %in% CodeSample]
    } else {
        valueSample = value
    }
    
    minX = quantile(valueSample, minXprob, na.rm=TRUE)
    maxX = quantile(valueSample, maxXprob, na.rm=TRUE)
    
    df_value = tibble(Code=Code, value=value)   
    if (all(CodeSample %in% Code)) {
        df_valueSample = tibble(Code=CodeSample, value=valueSample)
    } else {
        df_valueSample = tibble(Code=Code, value=valueSample)
    }
    res = list(df_value=df_value, df_valueSample=df_valueSample,
               min=minX, max=maxX)
    return (res)
}


count_decimal = function(x) {
    if ((x %% 1) != 0) {
        nchar(strsplit(sub('0+$', '',
                           as.character(x)), ".",
                       fixed=TRUE)[[1]][[2]])
    } else {
        return(0)
    }
}

get_trendLabel = function (rv, code, dataEX, trendEX, unit,
                           space=FALSE) {

    if (verbose) print("get_trendLabel")
    
    CodeEx = dataEX$Code[!duplicated(dataEX$Code)]
    CodeXtrend = trendEX$Code[!duplicated(trendEX$Code)]
    
    if (!(code %in% CodeEx) | !(code %in% CodeXtrend)) {
        return (NA)
    }
    
    dataEX_code = dataEX[dataEX$Code == code,]
    trendEX_code = trendEX[trendEX$Code == code,]

    if (is.na(trendEX_code$a)) {
        return (NA)
    }

    # Computes the mean of the data on the period
    dataMean = mean(dataEX_code[[rv$var]],
                    na.rm=TRUE)
    
    # Gets the trend
    trend = trendEX_code$a
    
    # Computes the mean trend
    trendMean = trend/dataMean
    # Computes the magnitude of the trend
    power = get_power(trend)
    # Converts it to character
    powerC = as.character(power)
    
    # If the power is positive
    if (power >= 0) {
        # Adds a space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        shiftC = '  '
        # Otherwise
    } else {
        # No space is added
        shiftC = ''
    }

    # Gets the power of ten of magnitude
    brk = 10^power
    # Converts trend to character for sientific expression
    trendC = as.character(format(round(trend / brk, 2),
                                 nsmall=2))
    # If the trend is positive
    if (trend >= 0) {
        # Adds two space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        trendC = paste(' ', trendC, sep='')
    }
    # Converts mean trend to character
    trendMeanC = as.character(format(round(trendMean*100, 2),
                                     nsmall=2))
    if (trendMean >= 0) {
        # Adds two space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        trendMeanC = paste(' ', trendMeanC, sep='')
    }

    if (space) {
        space = "    "
    } else {
        space = "&emsp;"
    }


    # If it is a date variable
    if (unit == 'jour' | unit == "jour de l'année") {
        # Create the name of the trend
        label = paste0(
            "<b>", trendC, " x ",
            "10<sup>", powerC, "</sup></b>", shiftC,
            " [jour.an<sup>-1</sup>]")

    } else if (unit == 'jour.an^{-1}') {
        # Create the name of the trend
        label = paste0(
            "<b>", trendC, " x ",
            "10<sup>", powerC, "</sup></b>", shiftC,
            " [jour.an<sup>-2</sup>]")
        
    } else {
        unitHTML = unit
        unitHTML = gsub('[/^][/{]', '<sup>', unitHTML)
        unitHTML = gsub('[/}]', '</sup>', unitHTML)
        # Create the name of the trend
        label = paste0(
            "<b>", trendC, " x ",
            "10<sup>", powerC, "</sup></b>", shiftC,
            " [", unitHTML, ".an<sup>-1</sup>]",
            space, "<b>",
            trendMeanC, "</b> [%.an<sup>-1</sup>]")
    }

    return (label)
}
