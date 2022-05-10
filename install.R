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
# install.R


install.packages("shiny")
install.packages("shinyjs")
install.packages("shinyWidgets")
install.packages("leaflet")
install.packages("dplyr")
install.packages("tools") # file_ext
install.packages("data.table") # fast reading
install.packages("sp") # crs
install.packages("sf") # crs
install.packages("ggplot2")
install.packages("ggtext")
install.packages("scales")

remotes::install_github("mitchelloharawild/icons")
remotes::install_github('trafficonese/leaflet.extras2@print_dpi')
remotes::install_github("https://github.com/benRenard/BFunk") 
remotes::install_github("https://github.com/vmansanarez/AoTre.git")
