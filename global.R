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
library(shinythemes)
library(shinyjs)
library(shinyWidgets)
library(leaflet)
library(leaflet.extras2)
library(StatsAnalysisTrend)
library(icons)
library(dplyr)
library(tools) # file_ext
library(data.table) # fast reading
library(sp) # crs
library(sf) # crs
library(ggplot2)
library(ggtext)
library(scales)
library(ggh4x)
library(plotly)


# Sourcing R files
source(file.path('R', 'tools.R'), encoding='UTF-8')
source(file.path('R', 'plot.R'), encoding='UTF-8')
source(file.path('R', 'color_manager.R'), encoding='UTF-8')
source(file.path('R', 'settings.R'), encoding='UTF-8')
source(file.path('R', 'marker_manager.R'), encoding='UTF-8')
source(file.path('R', 'style.R'), encoding='UTF-8')


# Sourcing app
source('server.R', encoding='UTF-8')
source('ui.R', encoding='UTF-8')


# Running app localy
shinyApp(ui=ui, server=server)

# Running app remotely
# rsconnect::deployApp()
