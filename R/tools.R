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
# R/tools.R


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
            
            if (grepl('^t.*', var)) {
                type = 'saisonnalité'
            } else {
                type = 'sévérité'
            } ### /!\ attention si y'a d'autre type
            
            if (var %in% names(varProba)) {
                proba = list(varProba[[which(names(varProba) == var)]])
            } else {
                proba = NA
            }
            
            Var = bind_rows(Var, tibble(event=event,
                                        var=var,
                                        varHTML=varHTML,
                                        name=name,
                                        type=type,
                                        proba=proba))
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
                         style="text-align: center;"),
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
                                 style="text-align: center;"),
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
                                   style="text-align: center;"),
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
                           style="text-align: center;"),
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
                                 style="text-align: center;"),
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
                       style="text-align: center;")
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
                       style="text-align: center;")
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
    
    updateRadioGroupButtons(
        session=session,
        status=class,
        label=NULL,
        choiceNames=choiceItems,
        choiceValues=choiceValues,
        ...)
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


page_circle = function (n, leftBase, widthHelp, top, dh, tooltip=NULL) {
    hidden(
        fixedPanel(id=paste0("c", n,"_panelButton"),
                   left=paste0("calc(", leftBase,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dh*(n-1), "px)"),
                   top=top,
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
                "maskTheme_panelButton",
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


read_FST = function (resdir, filename, filedir='fst') {
    outfile = file.path(resdir, filedir, filename)
    df = tibble(fst::read_fst(outfile))
    return (df)
}
# df_data = read_FST(computer_data_path, 'QIXAEx_01.fst', filedir='fst')
# df_meta = read_FST(computer_data_path, 'meta.fst', filedir='fst')


get_trendExtremes = function (df_data, df_trend, type,
                              minQprob=0, maxQprob=1) {
    
    if (type == 'sévérité') {
        df_mean = summarise(group_by(df_data, code),
                            mean=mean(Value, na.rm=TRUE))

        df_join = full_join(df_trend, df_mean, by="code")
        value = df_join$trend / df_join$mean
        Code = df_join$code
    } else {
        value = df_trend$trend
        Code = df_trend$code
    }

    minValue = quantile(value, minQprob, na.rm=TRUE)
    maxValue = quantile(value, maxQprob, na.rm=TRUE)

    df_value = tibble(code=Code, value=value)
    
    res = list(df_value=df_value, min=minValue, max=maxValue)
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
