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
library(zoo)
# already ::
library(RcppRoll)
library(CircStats)
library(Hmisc)
library(lubridate)
library(sf)
library(sp)


dev_lib_path =
    "/home/louis/Documents/bouleau/INRAE/project/"
    # ""


# Import EXstat
dev_path = file.path(dev_lib_path,
                     c('', 'EXstat_project'), 'EXstat', 'R')
if (any(file.exists(dev_path))) {
    print('Loading EXstat from local directory')
    list_path = list.files(dev_path, pattern='*.R$', full.names=TRUE)
    for (path in list_path) {
        source(path, encoding='UTF-8')
    }
} else {
    print('Loading EXstat from package')
    library(EXstat)
}

# Import ASHE
dev_path = file.path(dev_lib_path,
                     c('', 'ASHE_project'), 'ASHE', 'R')
if (any(file.exists(dev_path))) {
    print('Loading ASHE from local directory')
    list_path = list.files(dev_path, pattern='*.R$', full.names=TRUE)
    for (path in list_path) {
        source(path, encoding='UTF-8')
    }
} else {
    print('Loading ASHE from package')
    library(ASHE)
}


# Check if you are in dev mod
if (dir.exists(dev_lib_path)) {
    dev = TRUE
    verbose = TRUE
} else {
    dev = FALSE
    verbose = FALSE
}


# Sourcing R files
source('tools.R', encoding='UTF-8')
source('settings.R', encoding='UTF-8')
source('marker_manager.R', encoding='UTF-8')

# Sourcing app
source('server.R', encoding='UTF-8')
source('ui.R', encoding='UTF-8')

# Running app localy
shinyApp(ui=ui, server=server)

