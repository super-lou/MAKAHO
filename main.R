# Work path (it normally needs to end with '\\sht' directory)
computer_work_path = 
    "/home/louis/Documents/bouleau/INRAE/CDD_shiny/sht"

# Sets working directory
setwd(computer_work_path)

library(dplyr)


language = 'FR'
country = 'France'

urlTile =
# "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
# "https://tiles.stadiamaps.com/tiles/alidade_smooth/{z}/{x}/{y}{r}.png"
# "https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png"
# "https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}{r}.png"
# "https://tiles.stadiamaps.com/tiles/outdoors/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/light_nolabels/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/dark_nolabels/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png"
# "https://{s}.basemaps.cartocdn.com/rastertiles/voyager_nolabels/{z}/{x}/{y}{r}.png"
    # "https://{s}.basemaps.cartocdn.com/rastertiles/voyager_labels_under/{z}/{x}/{y}{r}.png"
# "https://{s}.tile.jawg.io/jawg-terrain/{z}/{x}/{y}{r}.png?access-token={accessToken}"
    # "https://{s}.tile.jawg.io/jawg-light/{z}/{x}/{y}{r}.png?access-token={accessToken}"
"https://{s}.tile.jawg.io/jawg-dark/{z}/{x}/{y}{r}.png?access-token={accessToken}"

if (grepl("jawg", urlTile, fixed=TRUE)) {
    provider = "jawg"
    token =
        "hEjAgwvvpEJBpIR62stbJUflOVZXM73MoB1hQGAR69fCtoNVQiHJOKp8lVlPOdFH"
} else {
    provider = ""
    token = NULL
}


if (provider == "jawg") {
    urlTile = sub("[{]accessToken[}]", token, urlTile)
}




# Path to the data
computer_data_path = file.path(computer_work_path, 'data')

# Resources directory
resources_path = file.path(computer_work_path, 'resources')


today = Sys.Date()

minZoom = 1
maxZoom = 13

varP = c(word("var1.3"), word("var3.3"))

dico_path = file.path(resources_path, 'dico.txt')
dico = tibble(read.table(dico_path, header=TRUE, sep=";"))
for (j in 1:ncol(dico)) {
    dico[j] = as.character(dico[[j]])
}

word = function (id) {
    w = dico[[language]][dico$id == id]
    return (w)
}

centroids_path = file.path(resources_path, 'centroids.txt')
centroids = tibble(read.table(centroids_path, header=TRUE,
                              quote='', sep=";"))
for (j in 1:ncol(centroids)) {
    if (is.factor(centroids[[j]])) {
        centroids[j] = as.character(centroids[[j]])
    }
}

area_path = file.path(resources_path, 'area.txt')
area = tibble(read.table(area_path, header=TRUE,
                              quote='', sep=";"))

area$country = as.character(area$country)
area$area = as.double(area$area)


get_listVar = function () {
    OkPhe = as.vector(regexpr("var[0-9]$", dico[[1]])) != -1
    IdPhe = which(OkPhe)
    nbPhe = sum(as.numeric(OkPhe))

    OkNumVar = as.vector(regexpr("var[0-9].[0-9]$", dico[[1]]))
    nbVar = with(rle(OkNumVar), lengths[values == 1])

    listIdVar = list()

    for (i in 1:nbPhe) {
        nbVar_phe = nbVar[i]
        sub_listIdVar = list()
        
        for (j in 1:nbVar_phe) {
            sub_listIdVar = append(sub_listIdVar,
                                   word(paste0("var", i, "." , j)))
        }
        listIdVar = append(listIdVar, list(sub_listIdVar))
        names(listIdVar)[length(listIdVar)] = word(paste0("var", i))
    } 
    return (listIdVar)
}


create_period = function (anHydro, dateStart, dateEnd) {
    monthStart = formatC(anHydro, width=2, flag=0)
    monthEnd = formatC((anHydro-2)%%12+1, width=2, flag=0)
    period = paste0(dateStart, "-", monthStart, "-01 / ",
                    dateEnd, "-", monthEnd, "-31")
    return (period)
}



source('ui.R', encoding='UTF-8')
source('server.R', encoding='UTF-8')
shinyApp(ui=ui, server=server)
