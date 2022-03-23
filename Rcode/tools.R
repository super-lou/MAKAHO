


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

get_varNameList = function () {
    OkPhe = as.vector(regexpr("var[0-9]$", dico[[1]])) != -1
    IdPhe = which(OkPhe)
    nbPhe = sum(as.numeric(OkPhe))

    OkNumVar = as.vector(regexpr("var[0-9].[0-9]$", dico[[1]]))
    nbVar = with(rle(OkNumVar), lengths[values == 1])

    IdList = list()

    for (i in 1:nbPhe) {
        nbVar_phe = nbVar[i]
        sub_IdList = list()
        
        for (j in 1:nbVar_phe) {
            sub_IdList = append(sub_IdList,
                                   word(paste0("var", i, "." , j)))
        }
        IdList = append(IdList, list(sub_IdList))
        names(IdList)[length(IdList)] = word(paste0("var", i))
    } 
    return (IdList)
}

get_urlTile = function (theme, provider, theme_file, resources_path) {
    
    theme_path = file.path(resources_path, theme_file)
    urlTiles = as.character(read.table(file=theme_path,
                                       header=FALSE,
                                       quote='"')[[1]])
        
    OkProvider = grepl(provider, urlTiles, fixed=TRUE)
    urlTiles_provider = urlTiles[OkProvider]

    # print(theme == )
    
    if (provider == "jawg") {
        if (theme == word("r.theme.light")) {
            themeUrl = 'light'
        } else if (theme == word("r.theme.ter")) {
            themeUrl = 'terrain'
        } else if (theme == word("r.theme.dark")) {
            themeUrl = 'dark'
        }
    }

    OkTheme = grepl(themeUrl, urlTiles_provider, fixed=TRUE)
    urlTile = urlTiles_provider[OkTheme]
    
    if (provider == "jawg") {
        token =
            "hEjAgwvvpEJBpIR62stbJUflOVZXM73MoB1hQGAR69fCtoNVQiHJOKp8lVlPOdFH"
        urlTile = sub("[{]accessToken[}]", token, urlTile)
    } else {
        stop("error")
    }
    return (urlTile)
}

# get_urlTile(word("r.theme.light"), 'jawg', 'theme.txt', resources_path)


get_icon = function (icon_dir, resources_path) {
    # icon_file = paste0(name, '.svg')
    iconLib = icon_set(file.path(resources_path, icon_dir))#, icon_file))
    return (iconLib)
}

actionButtonI = function (inputId, label, icon_name, width=NULL, ...){
    actionButton(inputId,
                 div(label,
                     style="float:right;padding-left:3px;"),
                 icon=NULL,
                 width=width,
                 img(icon_name, align="right"),
                 ...)
}


read_FST = function (resdir, filename, filedir='fst') {
    outfile = file.path(resdir, filedir, filename)
    df = tibble(fst::read_fst(outfile))
    return (df)
}


# df_data = read_FST(computer_data_path, 'data_QMNA_01.fst', filedir='fst')
# df_meta = read_FST(computer_data_path, 'meta.fst', filedir='fst')




get_trendExtremes = function (df_data, df_trend, CodeAll,
                              CodeSample, toMean=TRUE) {
    
    nCodeAll = length(CodeAll)
    
    # Blank array to store mean of the trend for each
    # station, perdiod and variable
    TrendValuesSample = c()
    TrendValuesAll = c()

    # For all the code
    for (k in 1:nCodeAll) {
        # Gets the code
        code = CodeAll[k]
        
        # Extracts the type of the variable
        # Extracts the data corresponding to the code
        df_data_code = df_data[df_data$code == code,] 
        df_trend_code = df_trend[df_trend$code == code,]

        # If it is a flow variable
        if (toMean) {
            # Computes the mean of the data on the period
            dataMean = mean(df_data_code$values, na.rm=TRUE) ### /!\
            # Normalises the trend value by the mean of the data
            trendValue = df_trend_code$trend / dataMean
            # If it is a date variable
        } else {
            trendValue = df_trend_code$trend
        }
        # Stores the mean trend
        TrendValuesAll = c(TrendValuesAll, trendValue)
        
        if (code %in% CodeSample) {
            TrendValuesSample = c(TrendValuesSample, trendValue)
        } else {
            TrendValuesSample = c(TrendValuesSample, NA)
        }
    }

    # Compute the min and the max of the mean trend for all the station
    minTrendValue = min(TrendValuesSample, na.rm=TRUE)
    maxTrendValue = max(TrendValuesSample, na.rm=TRUE)

    res = list(values=TrendValuesAll,
               min=minTrendValue, max=maxTrendValue)
    return (res)
}


PalettePerso = c('#0f3b57', # cold
                 '#1d7881',
                 '#80c4a9',
                 '#e2dac6', # mid
                 '#fadfad',
                 '#d08363',
                 '#7e392f') # hot


## 1. COLOR MANAGEMENT
### 1.1. Color on colorbar ___________________________________________
# Returns a color of a palette corresponding to a value included
# between the min and the max of the variable
get_color = function (value, min, max, nColor=256, palette_name='perso', reverse=FALSE) {

    # If the value is a NA return NA color
    if (is.na(value)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    midDown = round(nColor/2, 0)
    midUp = midDown
    if (nColor %% 2 == 0) {
        midUp = midUp + 1
    }
    if (reverse) {
        Sample_hot = 1:midDown
        Sample_cold = midUp:nColor
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
        
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    } else {
        Sample_hot = midUp:nColor
        Sample_cold = 1:midDown
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
    }
    
    nColor_hot = length(palette_hot)
    nColor_cold = length(palette_cold)

    # print(palette)
    # print('cold')
    # print(palette_cold)
    # print(Sample_cold)
    # print(nColor_cold)
    # print('hot')
    # print(palette_hot)
    # print(Sample_hot)
    # print(nColor_hot)    
    
    # Computes the absolute max
    maxAbs = max(abs(max), abs(min))

    # If the value is negative
    if (value <= 0) {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            # Gets the relative position of the value in respect
            # to its span
            idNorm = (value + maxAbs) / maxAbs
        }
        # The index corresponding
        id = round(idNorm*(nColor_cold - 1) + 1, 0)
        # The associated color
        color = palette_cold[id]
    # Same if it is a positive value
    } else {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            idNorm = value / maxAbs
        }
        id = round(idNorm*(nColor_hot - 1) + 1, 0)
        # The associated color
        color = palette_hot[id]
    }
    # print(idNorm)
    # print(id)
    # print(palette_hot)
    # print(color)
    return(color)
}

### 1.2. Colorbar ____________________________________________________
# Returns the colorbar but also positions, labels and colors of some
# ticks along it 
get_palette = function (min, max, nColor=256, palette_name='perso', reverse=FALSE, nbTick=10) {

    # If the value is a NA return NA color
    if (is.null(min) | is.null(max)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    midDown = round(nColor/2, 0)
    midUp = midDown
    if (nColor %% 2 == 0) {
        midUp = midUp + 1
    }
    if (reverse) {
        Sample_hot = 1:midDown
        Sample_cold = midUp:nColor
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
        
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    } else {
        Sample_hot = midUp:nColor
        Sample_cold = 1:midDown
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
    }
    
    nColor_hot = length(palette_hot)
    nColor_cold = length(palette_cold)

    # If the min and the max are below zero
    if (min < 0 & max < 0) {
        # The palette show is only the cold one
        paletteShow = palette_cold
    # If the min and the max are above zero
    } else if (min > 0 & max > 0) {
        # The palette show is only the hot one
        paletteShow = palette_hot
    # Else it is the entire palette that is shown
    } else {
        paletteShow = palette
    }

    # The position of ticks is between 0 and 1
    posTick = seq(0, 1, length.out=nbTick)
    # Blank vector to store corresponding labels and colors
    labTick = c()
    colTick = c()
    # For each tick
    for (i in 1:nbTick) {
        # Computes the graduation between the min and max
        lab = (i-1)/(nbTick-1) * (max - min) + min
        
        # Gets the associated color
        col = get_color(lab, min=min, max=max,
                        nColor=nColor,
                        palette_name=palette_name,
                        reverse=reverse)
        
        # Stores them
        labTick = c(labTick, lab)
        colTick = c(colTick, col)
    }
    # List of results
    res = list(palette=paletteShow, posTick=posTick,
               labTick=labTick, colTick=colTick)
    return(res)
}

### 1.3. Palette tester ______________________________________________
# Allows to display the current personal palette
palette_tester = function (palette_name='perso', figdir='figures', nColor=256) {

    outdir = file.path(figdir, 'palette')
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # An arbitrary x vector
    X = 1:nColor
    # All the same arbitrary y position to create a colorbar
    Y = rep(0, times=nColor)

    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    # Open a plot
    p = ggplot() + 
        # Make the theme blank
        theme(
            plot.background = element_blank(), 
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), 
            panel.border = element_blank(),
            panel.background = element_blank(),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_blank(), 
            axis.text.y = element_blank(),
            axis.ticks = element_blank(),
            axis.line = element_blank()
        )

    for (x in X) {
        # Plot the palette
        # geom_line(aes(x=X, y=Y), color=palette[X], size=60,
        # shape=15)

        p = p +
            annotate("segment",
                     x=x, xend=x,
                     y=0, yend=1, 
                     color=palette[x], size=1)
    }

    p = p +
        scale_x_continuous(limits=c(0, nColor),
                           expand=c(0, 0)) +
        
        scale_y_continuous(limits=c(0, 1),
                           expand=c(0, 0))

    # Saves the plot
    ggsave(plot=p,
           path=outdir,
           filename=paste(palette_name, '.pdf', sep=''),
           width=10, height=10, units='cm', dpi=100)

    ggsave(plot=p,
           path=outdir,
           filename=paste(palette_name, '.png', sep=''),
           width=10, height=10, units='cm', dpi=300)
}


## 2. USEFUL GENERICAL PLOT __________________________________________
### 2.1. Void plot ___________________________________________________
# A plot completly blank
void = ggplot() + geom_blank(aes(1,1)) +
    theme(
        plot.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(), 
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank()
    )


create_marker = function (resources_path, widthRel=1, filedir='marker', color='grey50', fill_PaletteName='perso', nColor=256, reverse=TRUE, stroke=1.5, fillAdd=NULL, colorAdd=NULL, ...) {

    # Names of a temporary directory to store all the independent pages
    outdir = file.path(resources_path, filedir)
    # Creates it if it does not exist
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    # If it already exists it deletes the pre-existent directory
    # and recreates one
    } else {
        unlink(outdir, recursive=TRUE)
        dir.create(outdir)
    }
    
    res = get_palette(-1, 1, nColor=nColor,
                      palette_name=fill_PaletteName,
                      reverse=reverse)
    Palette = res$palette
    if (!is.null(fillAdd)) {
        Palette = c(Palette, fillAdd)
    }
    nColorPalette = length(Palette)

    Color = rep(color, nColor)
    if (!is.null(colorAdd)) {
        Color = c(Color, colorAdd)
    }
    
    Shapes = c(21, 24, 25)
    Sizes = c(6, 7, 7)*widthRel
    Y = c(0, -0.02, 0.02)
    nMark = length(Shapes)
    
    Urls = c()
    for (i in 1:nColorPalette) {

        fill = Palette[i]
        color = Color[i]
        Filenames = paste0(Shapes, fill, '.svg')
        
        for (j in 1:nMark) {

            p = ggplot() + theme_void() +
                geom_point(aes(x=0, y=Y[j]), size=Sizes[j], stroke=stroke,
                           shape=Shapes[j], color=color, fill=fill, ...) +
                # X axis of the colorbar
                scale_x_continuous(limits=c(-0.1, 0.1),
                                   expand=c(0, 0)) +
                # Y axis of the colorbar
                scale_y_continuous(limits=c(-0.1, 0.1),
                                   expand=c(0, 0)) +
                # Margin of the colorbar
                theme(plot.margin=margin(t=0, r=0, b=0, l=0, unit="mm"))
            
            ggsave(plot=p,
                   path=outdir,
                   filename=Filenames[j],
                   width=100, height=100, units='px') # 100 px = 24 pt
            Urls = c(Urls, file.path(outdir, Filenames[j]))
        }
    }
    return (Urls)
}

# create_marker(resources_path, widthRel=0.8, stroke=0.8,
#               fill_PaletteName='perso',
#               color=grey50COL,
#               fillAdd=c(grey94COL, grey50COL),
#               colorAdd=c(grey85COL, grey50COL))


get_marker = function (shape, fill, resources_path, filedir) {

    if (shape == 'o') {
        shape = 21
    } else if (shape == '^') {
        shape = 24
    } else if (shape == 'v') {
        shape = 25
    }
    
    filename = paste0(shape, fill, '.svg')
    marker = makeIcon(file.path(resources_path, filedir, filename))
    return (marker)
}

# get_marker('o', '#0F3C57', resources_path, 'marker')

get_markerList = function (shapeList, fillList, resources_path, filedir='marker', width=20) {

    nMarkF = length(fillList)
    nMarkS = length(shapeList)
    if (nMarkF != nMarkS) {
        stop("fillList and shapeList have not the same length")
    } else {
        nMark = nMarkF
    }
    
    markerList = list()
    for (i in 1:nMark) {
        marker = get_marker(shapeList[i], fillList[i],
                            resources_path, filedir)
        markerList = append(markerList, marker)
    }
    # Not possible to resize with svg but 32 is the default
    # size hence the 16 for anchoring
    markerList = icons(markerList,
                       # iconWidth=24, iconHeight=24,
                       iconAnchorX=16, iconAnchorY=16) 
    return (markerList)
}

# markerList = get_markerList(c('o', '^', 'v'), c('#1B727D', '#0F3C57', '#C97C5E'), resources_path, 'marker', width=20)



makeReactiveTrigger = function () {
  rv = reactiveValues(a=0)
  list(
    depend = function() {
      rv$a
      invisible()
    },
    trigger = function() {
      rv$a = isolate(rv$a + 1)
    }
  )
}
