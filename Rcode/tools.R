


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




get_trendExtremes = function (df_data, df_trend, df_meta, toMean=TRUE) {

    Code = rle(df_meta$code)$values
    nCode = length(Code)
    
    # Blank array to store mean of the trend for each
    # station, perdiod and variable
    TrendValueList = c()

    # For all the code
    for (k in 1:nCode) {
        # Gets the code
        code = Code[k]
        
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
        TrendValueList = c(TrendValueList, trendValue)
    }

    # Compute the min and the max of the mean trend for all the station
    minTrendValue = min(TrendValueList, na.rm=TRUE)
    maxTrendValue = max(TrendValueList, na.rm=TRUE)

    res = list(value=TrendValueList,
               min=minTrendValue, max=maxTrendValue)
    return (res)
}


palette_perso = c('#0f3b57', # cold
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
get_color = function (value, min, max, ncolor=256, palette_name='perso', reverse=FALSE) {

    
    # If the value is a NA return NA color
    if (is.na(value)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = palette_perso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(ncolor)
    # Separates it in the middle to have a cold and a hot palette
    Sample_hot = 1:(as.integer(nSample/2)+1)
    Sample_cold = (as.integer(nSample/2)+1):nSample
    palette_hot = colorRampPalette(colorList[Sample_hot])(ncolor)
    palette_cold = colorRampPalette(colorList[Sample_cold])(ncolor)

    # Reverses the palette if it needs to be
    if (reverse) {
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    }

    # Computes the absolute max
    maxAbs = max(abs(max), abs(min))

    # If the value is negative
    if (value < 0) {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            # Gets the relative position of the value in respect
            # to its span
            idNorm = (value + maxAbs) / maxAbs
        }
        # The index corresponding
        id = round(idNorm*(ncolor - 1) + 1, 0)        
        # The associated color
        color = palette_cold[id]
    # Same if it is a positive value
    } else {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            idNorm = value / maxAbs
        }
        id = round(idNorm*(ncolor - 1) + 1, 0)
        color = palette_hot[id]
    }
    return(color)
}

### 1.2. Colorbar ____________________________________________________
# Returns the colorbar but also positions, labels and colors of some
# ticks along it 
get_palette = function (min, max, ncolor=256, palette_name='perso', reverse=FALSE, nbTick=10) {

    # If the value is a NA return NA color
    if (is.null(min) | is.null(max)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = palette_perso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(ncolor)
    # Separates it in the middle to have a cold and a hot palette
    Sample_hot = 1:(as.integer(nSample/2)+1)
    Sample_cold = (as.integer(nSample/2)+1):nSample
    palette_hot = colorRampPalette(colorList[Sample_hot])(ncolor)
    palette_cold = colorRampPalette(colorList[Sample_cold])(ncolor)

    # Reverses the palette if it needs to be
    if (reverse) {
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    }

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
                        ncolor=ncolor,
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
palette_tester = function (palette_name='perso', figdir='figures', n=256) {

    outdir = file.path(figdir, 'palette')
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = palette_perso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # An arbitrary x vector
    X = 1:n
    # All the same arbitrary y position to create a colorbar
    Y = rep(0, times=n)

    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(n)

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
        scale_x_continuous(limits=c(0, n),
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


get_marker = function (color, fill, outdir, id, size=10, stroke=1.5, shape='o', ...) {

    filename = paste0(id, '.png')
    
    if (shape == 'o') {
        shape = 21
    } else if (shape == '^') {
        shape = 24
    } else if (shape == 'v') {
        shape = 25
    }
    
    p = ggplot() + theme_void() +
        geom_point(aes(x=0, y=0), size=size, stroke=stroke,
                   shape=shape, color=color, fill=fill, ...) +
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
           filename=filename,
           width=1, height=1, units='cm', dpi=100)
    
    marker = makeIcon(file.path(outdir, filename))
    return (marker)
}

# get_marker('grey50', 'grey80', resources_path, 'marker', id=1, shape='o')

get_markerList = function (colorList, fillList, resources_path, filedir='marker', size=10, stroke=1.5, shape='o', ...) {

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

    nC = length(colorList)
    nF = length(fillList)

    if (nC == 1 & nF > 1) {
        colorList = rep(colorList, nF)
        n = nF
    } else if (nC > 1 & nF == 1) {
        fillList = rep(fillList, nC)
        n = nC
    } else if (nC > 1 & nF > 1) {
        stop ("colorList and fillList have not the same size or none of them have size one")
    } else {
        n = 1
    }

    print(n)
    
    markerList = list()
    for (i in 1:n) {
        marker = get_marker(colorList[i], fillList[i], outdir, id=i,
                            shape=shape, size=size, stroke=stroke)
        markerList = append(markerList, marker)
    }
    # class(markerList) = "leaflet_icon_set"
    return (icons(markerList))
}

# markerList = get_markerList('black', c('grey40', 'grey50', 'grey60'), resources_path)
