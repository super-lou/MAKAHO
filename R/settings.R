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
# R/settings.R


# Path to the data
computer_data_path = 'data'       

# Resources directory
resources_path = 'resources'

# INRAE logo path
INRAElogo_path = file.path(resources_path,
                           "logo", "Logo-INRAE_Transparent.png")

shp_dir = 'map'

# Path to the shapefile for basin shape from 'computer_data_path' 
bs_shpdir = file.path(shp_dir, 'bassin')
bs_shpname = 'BassinHydrographique.shp'

# Path to the shapefile for station basins shape from 'computer_data_path' 
cbs_shpdir = file.path(shp_dir, 'bassin_station')
cbs_shpname = c('BV_4207_stations.shp', '3BVs_FRANCE_L2E_2018.shp')
cbs_coord = c("L93", "L2")

# Path to the shapefile for river shape from 'computer_data_path' 
rv_shpdir = file.path('map', 'river')
rv_shpname = 'CoursEau_FXX.shp'

# Icon directory
icon_dir = 'icons'
# Creates icon library 
iconLib = create_iconLib(icon_dir, resources_path)

# Filename of the map tiles theme available
theme_file = 'theme.txt'
# Selection of the provider of map
provider =
    'jawg'
    # 'stadia'

# Token for the map 
jawg_token =
    "hEjAgwvvpEJBpIR62stbJUflOVZXM73MoB1hQGAR69fCtoNVQiHJOKp8lVlPOdFH"

# today's date
today = Sys.Date()

# Language
language = 'FR'

# Localisation
lonFR = 2.213749
latFR = 46.727638
zoomFR = 6
boundsFR = list(north=51.4677, east=17.68799,
                south=41.52503, west=-13.24951)

# Min and max zoom of the map
minZoom = 1
maxZoom = 20

# Name of the dictionnary to use for the translation
dico_file = 'dico.txt'
# Creates the dictionnary
dico = create_dico(dico_file, resources_path)




varProba = list(fA=c("90%", "95%", "99%"),
                Qp=c("10%", "25%", "50%", "75%", "90%"))

# Gets the variable name list
varNameList = get_varNameList(dico)
# Converts the 2 dimensional list into a vector
varNameVect = do.call(c, unlist(varNameList, recursive=FALSE))
names(varNameVect) = NULL

# Vector of variable abbreviations
varVect = c(
    "QIXA",
    "tQIXA",
    "fA",
    "QIXAniv",
    "tQIXAniv",
    "tDEBfon",
    "tCENfon",
    "tFINfon",
    "vFON",
    "tFON",
    "QA",
    "QMA",
    "Qp",
    "QNA",
    "QMNA",
    "VCN10",
    "tDEBeti",
    "tCENeti",
    "tFINeti",
    "vDEF",
    "tETI"
)

typeVect = c(
    "sévérité",
    "saisonnalité",
    NA,
    "sévérité",
    "saisonnalité",
    "saisonnalité",
    "saisonnalité",
    "saisonnalité",
    NA,
    "saisonnalité",
    "sévérité",
    "sévérité",
    "sévérité",
    "sévérité",
    "sévérité",
    "sévérité",
    "saisonnalité",
    "saisonnalité",
    "saisonnalité",
    NA,
    "saisonnalité"
)

# Variables that need a percentage
varP = c("fA",
         "Qp")

# Possible percentages for variables that need one
valP = list(c("90%", "95%", "99%"),
            c("10%", "25%", "50%", "75%", "90%"))



Var = get_Var(dico, varProba)



# Creates a vector of months name
Months = c(word("a.m01"), word("a.m02"), word("a.m03"), word("a.m04"),
           word("a.m05"), word("a.m06"), word("a.m07"), word("a.m08"),
           word("a.m09"), word("a.m10"), word("a.m11"), word("a.m12"))

# Creates a vector of years
Years = 1900:as.numeric(format(today, "%Y"))

# Level of risk
sigP = c("1%", "5%", "10%")

palette_name = 'perso'
palette_reverse = TRUE
nbTick = 10


