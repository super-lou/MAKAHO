# Copyright 2022-2023 Louis Héraut (louis.heraut@inrae.fr)*1,
#                     Éric Sauquet (eric.sauquet@inrae.fr)*1,
#                     Michel Lang (michel.lang@inrae.fr)*1,
#                     Jean-Philippe Vidal (jean-philippe.vidal@inrae.fr)*1,
#                     Benjamin Renard (benjamin.renard@inrae.fr)*1
#                     
# *1   INRAE, France
#
# This file is part of MAKAHO R shiny app.
#
# MAKAHO R shiny app is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MAKAHO R shiny app is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MAKAHO R shiny app.
# If not, see <https://www.gnu.org/licenses/>.


# Import library
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(leaflet)
library(icons)
library(dplyr)
library(stringr)
# already ::
library(RcppRoll)
library(CircStats)
library(Hmisc)
library(lubridate)
library(sf)
library(sp)

dev_path_ASHE = file.path(dirname(dirname(getwd())),
                           "ASHE_project",
                           'ASHE', 'R')
if (file.exists(dev_path_ASHE)) {
    print('Loading ASHE from local directory')
    list_path_ASHE = list.files(dev_path_ASHE,
                                 pattern="*.R$",
                                 full.names=TRUE)
    for (path_ASHE in list_path_ASHE) {
        source(path_ASHE, encoding='UTF-8')
    }
} else {
    print('Loading ASHE from package')
    library(ASHE)
}

dev_path_EXstat = file.path(dirname(dirname(getwd())),
                           "EXstat_project",
                           'EXstat', 'R')
if (file.exists(dev_path_EXstat)) {
    print('Loading EXstat from local directory')
    list_path_EXstat = list.files(dev_path_EXstat,
                                 pattern="*.R$",
                                 full.names=TRUE)
    for (path_EXstat in list_path_EXstat) {
        source(path_EXstat, encoding='UTF-8')
    }
} else {
    print('Loading EXstat from package')
    library(EXstat)
}

dev_path_dataSheep = file.path(dirname(dirname(getwd())),
                     'dataSheep_project', 'dataSheep', 'R')
if (file.exists(dev_path_dataSheep)) {
    print('Loading dataSheep from local directory')
    list_path_dataSheep = list.files(dev_path_dataSheep, pattern="*.R$", full.names=TRUE)
    for (path_dataSheep in list_path_dataSheep) {
        source(path_dataSheep, encoding='UTF-8')    
    }
} else {
    print('Loading dataSheep from package')
    library(dataSheep)
}

# Sourcing R files
source(file.path('R', 'tools.R'), encoding='UTF-8')
source(file.path('R', 'settings.R'), encoding='UTF-8')
source(file.path('R', 'marker_manager.R'), encoding='UTF-8')

# Sourcing app
source('server.R', encoding='UTF-8')
source('ui.R', encoding='UTF-8')

# Running app localy
shinyApp(ui=ui, server=server)
