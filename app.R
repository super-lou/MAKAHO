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
# main.R


# Work path (it normally needs to end with '\\sht' directory)
computer_work_path = 
    "/home/louis/Documents/bouleau/INRAE/CDD_shiny/shinhydrology"

# Sets working mapdirectory
setwd(computer_work_path)

# Import library

# library(shiny)
# library(shinyjs)
# library(shinyWidgets)
# library(leaflet)
# library(leaflet.extras2)
# library(StatsAnalysisTrend)
# library(icons)
# library(dplyr)
# library(tools) # file_ext
# library(data.table) # fast reading
# library(sp) # crs
# library(sf) # crs
# library(ggplot2)
# library(ggtext)

if (!require(shiny)) install.packages("shiny")
if (!require(shinyjs)) install.packages("shinyjs")
if (!require(shinyWidgets)) install.packages("shinyWidgets")
if (!require(leaflet)) install.packages("leaflet")
if (!require(leaflet.extras2)) {
    remotes::install_github('trafficonese/leaflet.extras2@print_dpi')
}
if (!require(StatsAnalysisTrend)) {
    remotes::install_github("https://github.com/benRenard/BFunk")
    remotes::install_github("https://github.com/vmansanarez/AoTre.git")
}
if (!require(icons)) remotes::install_github("mitchelloharawild/icons")
if (!require(dplyr)) install.packages("dplyr")
if (!require(tools)) install.packages("tools")
if (!require(data.table)) install.packages("data.table")
if (!require(sp)) install.packages("sp")
if (!require(sf)) install.packages("sf")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(ggtext)) install.packages("ggtext")

# Sourcing R files
source(file.path('R', 'tools.R'), encoding='UTF-8')
source(file.path('R', 'plot.R'), encoding='UTF-8')
source(file.path('R', 'color_manager.R'), encoding='UTF-8')
source(file.path('R', 'marker_manager.R'), encoding='UTF-8')
source(file.path('R', 'style.R'), encoding='UTF-8')
source(file.path('R', 'settings.R'), encoding='UTF-8')

# Sourcing app
source(file.path('R', 'ui.R'), encoding='UTF-8')
source(file.path('R', 'server.R'), encoding='UTF-8')

# Running app
shinyApp(ui=ui, server=server)
