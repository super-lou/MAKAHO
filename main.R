# Work path (it normally needs to end with '\\sht' directory)
computer_work_path = 
    "/home/louis/Documents/bouleau/INRAE/CDD_shiny/sht"

# Sets working directory
setwd(computer_work_path)

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(icons)
library(leaflet)
library(dplyr)
library(tools) # file_ext
library(data.table) # fast reading
library(sp) # crs
library(sf) # crs
library(StatsAnalysisTrend)
library(ggplot2)


grey97COL = "#f7f7f7"
grey94COL = "#f0f0f0"
grey85COL = "#d9d9d9"
grey50COL = "#808080"


source(file.path('Rcode', 'tools.R'))
source(file.path('Rcode', 'style.R'))

# Path to the data
computer_data_path = file.path(computer_work_path, 'data')            

# Resources directory
resources_path = file.path(computer_work_path, 'resources')

INRAElogo_path = file.path(resources_path,
                           "logo", "Logo-INRAE_Transparent.png")

# # Result directory
# resdir = file.path(computer_work_path, 'results')
# if (!(file.exists(resdir))) {
#   dir.create(resdir)
# }
# print(paste('resdir :', resdir))

icon_dir = 'icons'
iconLib = get_icon(icon_dir, resources_path)

theme_file = 'theme.txt'
provider = 'jawg'

today = Sys.Date()

language = 'FR'
country = 'France'

minZoom = 1
maxZoom = 13

dico_file = 'dico.txt'
dico = create_dico(dico_file, resources_path)


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

varNameList = get_varNameList()
varNameVect = do.call(c, unlist(varNameList, recursive=FALSE))
names(varNameVect) = NULL

Months = c(word("a.m01"), word("a.m02"), word("a.m03"), word("a.m04"),
           word("a.m05"), word("a.m06"), word("a.m07"), word("a.m08"),
           word("a.m09"), word("a.m10"), word("a.m11"), word("a.m12"))
Years = 1900:as.numeric(format(today, "%Y"))

varVect = c(
    "MAXAN",
    "tMAXAN",
    "fA",
    "MAXANniv",
    "tMAXANniv",
    "tDEBfon",
    "tMEDfon",
    "tFINfon",
    "VOLfon",
    "tFON",
    "QA",
    "QMA",
    "Qp",
    "QNA",
    "QMNA",
    "VCN10",
    "tDEBeti",
    "tMEDeti",
    "tFINeti",
    "VOLdef",
    "tETI"
)

varP = c("fA",
         "Qp")

valP = list(c("90%", "95%", "99%"),
            c("10%", "25%", "50%", "75%", "90%"))

sigP = c("1%", "5%", "10%")


# create_marker(resources_path)

source('ui.R', encoding='UTF-8')
source('server.R', encoding='UTF-8')
shinyApp(ui=ui, server=server)

