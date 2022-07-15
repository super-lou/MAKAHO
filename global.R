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
# dev_path = file.path(dirname(dirname(getwd())),
#                      'CDD_stationnarite', 'ash', 'R')
# if (file.exists(dev_path)) {
#     print('Loading ash from local directory')
#     list_path = list.files(dev_path, pattern="*.R$", full.names=TRUE)
#     for (path in list_path) {
#         source(path, encoding='UTF-8')
#     }
# } else {
#     print('Loading ash from package')
#     library(ash)
# }


lapply(names(sessionInfo()$otherPkgs), function(pkgs)
    detach(
        paste0('package:', pkgs),
        character.only = T,
        unload = T,
        force = T
    ))


print(.packages())
print(sessionInfo())

print("library ash")
library(ash)
print(sessionInfo())

print("requireNamespace ash")
requireNamespace("ash")
print(sessionInfo())

print("other library")
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(leaflet)
library(StatsAnalysisTrend)
library(icons)
library(dplyr)
print(sessionInfo())


# Sourcing R files
source(file.path('R', 'tools.R'), encoding='UTF-8')
source(file.path('R', 'plot.R'), encoding='UTF-8')
source(file.path('R', 'settings.R'), encoding='UTF-8')
source(file.path('R', 'marker_manager.R'), encoding='UTF-8')
source(file.path('R', 'server', 'short.R'), encoding='UTF-8')


# Sourcing app
source('server.R', encoding='UTF-8')
source('ui.R', encoding='UTF-8')


# Running app localy
shinyApp(ui=ui, server=server)
