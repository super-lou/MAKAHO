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


# Sourcing dependencies
source(file.path('R', 'dependencies.R'), encoding='UTF-8')


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

actionButtonI = function (inputId, label=NULL, icon_name=NULL,
                          width=NULL, ...){
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
# df_data = read_FST(computer_data_path, 'VCN10Ex_01.fst', filedir='fst')
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




get_label = function (Lon, Lat, Code, Nom) {
    label = paste0(
        "<b>", word('m.hov.lat'),". </b>",
        signif(Lat, 6),
        " / <b>", word('m.hov.lon'),". </b>",
        signif(Lon, 6), '<br>',
        "<b>", word('m.hov.code')," </b>",
        Code, '<br>',
        "<b>", word('m.hov.name')," </b>",
        Nom, '<br>'
    )
    return (label)
}


## 4. SHAPEFILE MANAGEMENT ___________________________________________
#' @title Shapefiles loading
#' @description  Generates a list of shapefiles to draw a hydrological
#' map of the France
#' @param resources_path Path to the resources directory.
#' @param bs_shpdir Directory you want to use in ash\\resources_path\\
#' to get the hydrological basin shapefile.
#' @param bs_shpname Name of the hydrological basin shapefile.
#' @param rv_shpdir Directory you want to use in ash\\resources_path\\
#' to get the hydrological network shapefile.
#' @param rv_shpname  Name of the hydrological network shapefile.
#' @param show_river Boolean to indicate if the shapefile of the
#' hydrological network will be charge because it is a heavy one and
#' that it slows down the entire process (default : TRUE)
#' @return A list of shapefiles converted as tibbles that can be plot
#' with 'geom_polygon' or 'geom_path'.
#' @export
ini_shapefile = function (resources_path, Code,
                          bs_shpdir, bs_shpname,
                          cbs_shpdir, cbs_shpname, cbs_coord,
                          rv_shpdir, rv_shpname, show_river=TRUE) {
    
    # Path for shapefile
    bs_shppath = file.path(resources_path, bs_shpdir, bs_shpname)
    cbs_shppath = file.path(resources_path, cbs_shpdir, cbs_shpname)
    rv_shppath = file.path(resources_path, rv_shpdir, rv_shpname)

    # Hydrological basin
    basin = readOGR(dsn=bs_shppath, verbose=FALSE)
    df_basin = tibble(fortify(basin))

    df_codeBasin = tibble()
    CodeOk = c()
    nShp = length(cbs_shppath)
    # Hydrological stations basins
    for (i in 1:nShp) {
        codeBasin = readOGR(dsn=cbs_shppath[i], verbose=FALSE)
        shpCode = as.character(codeBasin@data$Code)
        df_tmp = tibble(fortify(codeBasin))
        groupSample = rle(as.character(df_tmp$group))$values
        df_tmp$code = shpCode[match(df_tmp$group, groupSample)]
        df_tmp = df_tmp[df_tmp$code %in% Code &
                        !(df_tmp$code %in% CodeOk),]
        CodeOk = c(CodeOk, shpCode[!(shpCode %in% CodeOk)])

        if (cbs_coord[i] == "L2") {
            crs_rgf93 = st_crs(2154)
            crs_l2 = st_crs(27572)
            sf_loca = st_as_sf(df_tmp[c("long", "lat")],
                               coords=c("long", "lat"))
            st_crs(sf_loca) = crs_l2
            sf_loca = st_transform(sf_loca, crs_rgf93)
            sf_loca = st_coordinates(sf_loca$geometry)
            df_tmp$long = sf_loca[, 1]
            df_tmp$lat = sf_loca[, 2]
        }
        df_codeBasin = bind_rows(df_codeBasin, df_tmp)
    }
    df_codeBasin = df_codeBasin[order(df_codeBasin$code),]
    
    # If the river shapefile needs to be load
    if (show_river) {
        # Hydrographic network
        river = readOGR(dsn=rv_shppath, verbose=FALSE) ### trop long ###
        river = river[which(river$Classe == 1),]
        df_river = tibble(fortify(river))
    } else {
        df_river = NULL
    }
    return (list(basin=df_basin,
                 codeBasin=df_codeBasin,
                 river=df_river))
}




create_ReactiveTrigger = function() {
  rv <- reactiveValues(a = 0)
  list(
    depend = function() {
      rv$a
      invisible()
    },
    trigger = function() {
      rv$a <- isolate(rv$a + 1)
    }
  )
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




## 3. NUMBER MANAGEMENT ______________________________________________
### 3.1. Number formatting ___________________________________________
# Returns the power of ten of the scientific expression of a value
get_power = function (value) {

    # Do not care about the sign
    value = abs(value)
    
    # If the value is greater than one
    if (value >= 1) {
        # The magnitude is the number of character of integer part
        # of the value minus one
        power = nchar(as.character(as.integer(value))) - 1
    # If value is zero
    } else if (value == 0) {
        # The power is zero
        power = 0
    # If the value is less than one
    } else {
        # Extract the decimal part
        dec = gsub('0.', '', as.character(value), fixed=TRUE)
        # Number of decimal with zero
        ndec = nchar(dec)
        # Number of decimal without zero
        nnum = nchar(as.character(as.numeric(dec)))
        # Compute the power of ten associated
        power = -(ndec - nnum + 1)
    }
    return(power)
}

### 3.2. Pourcentage of variable _____________________________________
# Returns the value corresponding of a certain percentage of a
# data serie
gpct = function (pct, L, min_lim=NULL, shift=FALSE) {

    # If no reference for the serie is given
    if (is.null(min_lim)) {
        # The minimum of the serie is computed
        minL = min(L, na.rm=TRUE)
    # If a reference is specified
    } else {
        # The reference is the minimum
        minL = min_lim
    }

    # Gets the max
    maxL = max(L, na.rm=TRUE)
    # And the span
    spanL = maxL - minL
    # Computes the value corresponding to the percentage
    xL = pct/100 * as.numeric(spanL)

    # If the value needs to be shift by its reference
    if (shift) {
        xL = xL + minL
    }
    return (xL)
}

### 3.3. Add months __________________________________________________
add_months = function (date, n) {
    new_date = seq(date, by = paste (n, "months"), length = 2)[2]
    return (new_date)
}


### 3.2. Cleaning ____________________________________________________
# Cleans the trend results of the function 'Estimate.stats' in the
# 'StatsAnalysisTrend' package. It adds the station code and the
# intercept of the trend to the trend results. Also makes the data
# more presentable.
clean = function (period, df_Xtrend, df_XEx) {

    df_Xtrend = get_period(period, df_Xtrend, df_XEx)
    
    # Adds the intercept value of trend
    df_Xtrend = get_intercept(df_Xtrend, df_XEx)
    
    # Changes the position of the intercept column
    df_Xtrend = relocate(df_Xtrend, intercept, .after=trend)

    return (df_Xtrend)
}


### 3.1. Period of trend _____________________________________________
# Compute the start and the end of the period for a trend analysis
# according to the accessible data 
get_period = function (period, df_Xtrend, df_XEx) {

    # Converts results of trend to tibble
    df_Xtrend = tibble(df_Xtrend)

    df_Start = summarise(group_by(df_XEx, group1),
                         period_start=datetime[which.min(abs(datetime - as.Date(period[1])))])
    
    df_End = summarise(group_by(df_XEx, group1),
                       period_end=datetime[which.min(abs(datetime - as.Date(period[2])))])
    
    df_Xtrend$period_start = df_Start$period_start
    df_Xtrend$period_end = df_End$period_end 
    
    return (df_Xtrend)
}


### 1.0. Intercept of trend __________________________________________
# Compute intercept values of linear trends with first order values
# of trends and the data on which analysis is performed.
get_intercept = function (df_Xtrend, df_XEx, unit2day=365.25) {

    # Converts results of trend to tibble
    df_Xtrend = tibble(df_Xtrend)
    
    df_mu_X = summarise(group_by(df_XEx, group1),
                        mu_X=mean(values, na.rm=TRUE))

    df_mu_t = summarise(group_by(df_XEx, group1),
                        mu_t=as.numeric(mean(datetime, na.rm=TRUE)) / unit2day)

    df_Xtrendtmp = tibble(group1=df_Xtrend$group1,
                          trend=df_Xtrend$trend,
                          mu_X=df_mu_X$mu_X,
                          mu_t=df_mu_t$mu_t)
    
    df_b = summarise(group_by(df_Xtrendtmp, group1),
                     b=mu_X - mu_t * trend)

    df_Xtrend$intercept = df_b$b

    # # Create a column in trend full of NA
    # df_Xtrend$intercept = NA

    # # For all different group
    # for (g in df_XEx$group1) {
    #     # Get the data and trend value linked to this group
    #     df_data_code = df_XEx[df_XEx$group1 == g,]
    #     df_Xtrend_code = df_Xtrend[df_Xtrend$group1 == g,]

    #     # Get the time start and end of the different periods
    #     Start = df_Xtrend_code$period_start
    #     End = df_Xtrend_code$period_end

    #     # Get the group associated to this period
    #     id = which(df_Xtrend$group1 == g 
    #                & df_Xtrend$period_start == Start
    #                & df_Xtrend$period_end == End)

    #     # Compute mean of flow and time period
    #     mu_X = mean(df_data_code$values, na.rm=TRUE)
    #     mu_t = as.numeric(mean(c(Start, End), na.rm=TRUE)) / unit2day

    #     # Get the intercept of the trend
    #     b = mu_X - mu_t * df_Xtrend_code$trend
    #     # And store it
    #     df_Xtrend$intercept[id] = b
    # }    
    return (df_Xtrend)
}
