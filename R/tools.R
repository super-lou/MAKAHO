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
