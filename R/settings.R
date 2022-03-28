
# Import library
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

# Path to the data
computer_data_path = file.path(computer_work_path, 'data')            

# Resources directory
resources_path = file.path(computer_work_path, 'resources')

# INRAE logo path
INRAElogo_path = file.path(resources_path,
                           "logo", "Logo-INRAE_Transparent.png")

# Icon directory
icon_dir = 'icons'
# Creates icon library 
iconLib = create_iconLib(icon_dir, resources_path)

# Filename of the map tiles theme available
theme_file = 'theme.txt'
# Selection of the provider of map 
provider = 'jawg'

# today's date
today = Sys.Date()

# Language
language = 'FR'

# Country
country = 'France'

# Min and max zoom of the map
minZoom = 1
maxZoom = 13

# Name of the dictionnary to use for the translation
dico_file = 'dico.txt'
# Creates the dictionnary
dico = create_dico(dico_file, resources_path)

# Name of the file of centroids for every countries
centroids_file = 'centroids.txt'
# Gets the centroids
centroids = create_centroids(centroids_file, resources_path)

# Name of the file of area for every countries
area_file = 'area.txt'
# Gets the area
area = create_area(area_file, resources_path)

# Gets the variable name list
varNameList = get_varNameList()
# Converts the 2 dimensional list into a vector
varNameVect = do.call(c, unlist(varNameList, recursive=FALSE))
names(varNameVect) = NULL

# Vector of variable abbreviations
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

# Variables that need a percentage
varP = c("fA",
         "Qp")

# Possible percentages for variables that need one
valP = list(c("90%", "95%", "99%"),
            c("10%", "25%", "50%", "75%", "90%"))

# Creates a vector of months name
Months = c(word("a.m01"), word("a.m02"), word("a.m03"), word("a.m04"),
           word("a.m05"), word("a.m06"), word("a.m07"), word("a.m08"),
           word("a.m09"), word("a.m10"), word("a.m11"), word("a.m12"))

# Creates a vector of years
Years = 1900:as.numeric(format(today, "%Y"))

# Level of risk
sigP = c("1%", "5%", "10%")

# Creates all marker possibilities
# create_marker(resources_path)

