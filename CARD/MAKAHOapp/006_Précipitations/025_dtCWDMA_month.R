#   ___                _ 
#  / __| __ _  _ _  __| |
# | (__ / _` || '_|/ _` |
#  \___|\__,_||_|  \__,_|
# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
#
# This file is part of CARD R library.
#
# CARD R library is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# CARD R library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CARD R library.
# If not, see <https://www.gnu.org/licenses/>.


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = c("dtCWDMA_jan", "dtCWDMA_feb", "dtCWDMA_mar",
                       "dtCWDMA_apr", "dtCWDMA_may", "dtCWDMA_jun",
                       "dtCWDMA_jul", "dtCWDMA_aug", "dtCWDMA_sep",
                       "dtCWDMA_oct", "dtCWDMA_nov", "dtCWDMA_dec")
CARD$P.unit_en = "day"
CARD$P.name_en = ""
CARD$P.description_en = c("Maximum number of consecutive days with at least 1 mm of precipitation for each January",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each February",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each March",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each April",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each May",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each June",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each July",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each August",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each September",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each October",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each November",
                          "Maximum number of consecutive days with at least 1 mm of precipitation for each December")
CARD$P.method_en = ""
CARD$P.topic_en = "Precipitations, Dry period, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = c("dtCWDMA_janv", "dtCWDMA_fevr", "dtCWDMA_mars",
                       "dtCWDMA_avril", "dtCWDMA_mai", "dtCWDMA_juin",
                       "dtCWDMA_juil", "dtCWDMA_aout", "dtCWDMA_sept",
                       "dtCWDMA_oct", "dtCWDMA_nov", "dtCWDMA_dec")
CARD$P.unit_fr = "jour"
CARD$P.name_fr = c("Nombre maximal de jours pluvieux consécutifs de chaque janvier",
                   "Nombre maximal de jours pluvieux consécutifs de chaque février",
                   "Nombre maximal de jours pluvieux consécutifs de chaque mars",
                   "Nombre maximal de jours pluvieux consécutifs de chaque avril",
                   "Nombre maximal de jours pluvieux consécutifs de chaque mai",
                   "Nombre maximal de jours pluvieux consécutifs de chaque juin",
                   "Nombre maximal de jours pluvieux consécutifs de chaque juillet",
                   "Nombre maximal de jours pluvieux consécutifs de chaque août",
                   "Nombre maximal de jours pluvieux consécutifs de chaque septembre",
                   "Nombre maximal de jours pluvieux consécutifs de chaque octobre",
                   "Nombre maximal de jours pluvieux consécutifs de chaque novembre",
                   "Nombre maximal de jours pluvieux consécutifs de chaque décembre")
CARD$P.description_fr = c("Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque janvier",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque février",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque mars",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque avril",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque mai",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque juin",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque juillet",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque août",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque septembre",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque octobre",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque novembre",
                          "Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque décembre")
CARD$P.method_fr = ""
CARD$P.topic_fr = "Précipitations, Période sèche, Durée"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(dtCWDMA=apply_threshold)
CARD$P1.funct_args = list("R", lim=1, where=">=", what="length", select="longest")
CARD$P1.time_step = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

