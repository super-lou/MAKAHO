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

Var = get_Var(dico, varProba)


# Creates a vector of months name
Months = c(word("ana.m01"), word("ana.m02"), word("ana.m03"),
           word("ana.m04"), word("ana.m05"), word("ana.m06"),
           word("ana.m07"), word("ana.m08"), word("ana.m09"),
           word("ana.m10"), word("ana.m11"), word("ana.m12"))

# Creates a vector of years
Years = 1900:as.numeric(format(today, "%Y"))

# Level of risk
sigProba = c("1%", "5%", "10%")
sigVal = as.numeric(gsub('%', '' , sigProba))/100

nbTick = 10

colorStep = 10
Palette = Palette_ground
reverse = FALSE

analyseMinYear = 30

validColor = grey50COL
invalidColor = yellowCOL
missColor = redCOL

none1Color_light = grey85COL
none2Color_light = grey94COL

none1Color_dark = grey9COL
none2Color_dark = grey18COL


N_helpPage = 14
widthHelp = 350
leftHelp = "52%"
topHelp = "50%"
dyNavHelp = 250
dhNavHelp = 22
