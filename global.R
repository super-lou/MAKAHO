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
# global.R


# Import library
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(leaflet)
library(StatsAnalysisTrend)
library(icons)
library(dplyr)
library(stringr)
# already ::
library(accelerometry)
library(CircStats)
library(Hmisc)
library(lubridate)
library(sf)
library(sp)

dev_path_ashes = file.path(dirname(dirname(getwd())),
                           "ashes_project",
                           'ashes', 'R')
if (file.exists(dev_path_ashes)) {
    print('Loading ashes from local directory')
    list_path_ashes = list.files(dev_path_ashes,
                                 pattern="*.R$",
                                 full.names=TRUE)
    for (path_ashes in list_path_ashes) {
        source(path_ashes, encoding='UTF-8')
    }
} else {
    print('Loading ashes from package')
    library(ashes)
}

dev_path_MKstat = file.path(dirname(dirname(getwd())),
                           "MKstat_project",
                           'MKstat', 'R')
if (file.exists(dev_path_MKstat)) {
    print('Loading MKstat from local directory')
    list_path_MKstat = list.files(dev_path_MKstat,
                                 pattern="*.R$",
                                 full.names=TRUE)
    for (path_MKstat in list_path_MKstat) {
        source(path_MKstat, encoding='UTF-8')
    }
} else {
    print('Loading MKstat from package')
    library(MKstat)
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
