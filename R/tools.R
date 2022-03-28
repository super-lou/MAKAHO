


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
    OkPhe = as.vector(regexpr("a.var[0-9]$", dico[[1]])) != -1
    IdPhe = which(OkPhe)
    nbPhe = sum(as.numeric(OkPhe))

    OkNumVar = as.vector(regexpr("a.var[0-9].[0-9]$", dico[[1]]))
    nbVar = with(rle(OkNumVar), lengths[values == 1])

    IdList = list()

    for (i in 1:nbPhe) {
        nbVar_phe = nbVar[i]
        sub_IdList = list()
        
        for (j in 1:nbVar_phe) {
            sub_IdList = append(sub_IdList,
                                   word(paste0("a.var", i, "." , j)))
        }
        IdList = append(IdList, list(sub_IdList))
        names(IdList)[length(IdList)] = word(paste0("a.var", i))
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

actionButtonI = function (inputId, label, icon_name, width=NULL, ...){
    actionButton(inputId,
                 div(label,
                     style="float:right; padding-left:3px;"),
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




