# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1,
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


## 1. PACKAGES _______________________________________________________
### 1.1. Library _____________________________________________________
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(leaflet)
library(icons)
library(dplyr)
library(stringr)
# library(zoo)
# already ::
# library(RcppRoll)
# library(CircStats)
# library(Hmisc)
library(lubridate)
library(sf)
# library(sp)


### 1.2. Source ______________________________________________________
#### 1.2.0. work path ________________________________________________
dev_lib_path =
    "/home/louis/Documents/bouleau/INRAE/project/"
    # ""

#### 1.2.1. EXstat ___________________________________________________
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

#### 1.2.2. ASHE _____________________________________________________
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

#### 1.2.3. dataSHEEP ________________________________________________
dev_path = file.path(dev_lib_path,
                     c('', 'dataSHEEP_project'), 'dataSHEEP', 'R')
if (any(file.exists(dev_path))) {
    print('Loading dataSHEEP from local directory')
    list_path = list.files(dev_path, pattern='*.R$', full.names=TRUE)
    for (path in list_path) {
        source(path, encoding='UTF-8')
    }
} else {
    print('Loading dataSHEEP from package')
    library(dataSHEEP)
}


## 2. INITIALISATION _________________________________________________
# Check if you are in dev mod
if (dir.exists(dev_lib_path)) {
    dev = TRUE
    verbose = TRUE
} else {
    dev = FALSE
    verbose = FALSE
}

# language
lg = "fr"

# Sourcing R files
source('tools.R', encoding='UTF-8')
source('settings.R', encoding='UTF-8')
source('marker_manager.R', encoding='UTF-8')

# Sourcing app
source('server.R', encoding='UTF-8')
source('ui.R', encoding='UTF-8')


# Running app local
shinyApp(ui=ui, server=server)

