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
CARD$P.variable_en = c("meanRA_DJF", "meanRA_MAM",
                       "meanRA_JJA", "meanRA_SON")
CARD$P.unit_en = "mm"
CARD$P.name_en = c("Average total precipitations of each winter (months of December, January and February)",
                   "Average total precipitations of each spring (months of March, April and May)",
                   "Average total precipitations of each summer (months of June, July and August)",
                   "Average total precipitations of each fall (months of September, October and November)")
CARD$P.method_en = c("1. seasonal annual aggregation [12-01, 02-28(29)] - average
2. no temporal aggregation - average",
"1. seasonal annual aggregation [03-01, 05-31] - average
2. no temporal aggregation - average",
"1. seasonal annual aggregation [06-01, 08-31] - average
2. no temporal aggregation - average",
"1. seasonal annual aggregation [09-01, 11-30] - average
2. no temporal aggregation - average")
CARD$P.sampling_period_en = c("12-01, 02-28(29)",
                              "03-01, 05-31",
                              "06-01, 08-31",
                              "09-01, 11-30")
CARD$P.topic_en = "Precipitations, Moderate, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = c("moyRA_DJF", "moyRA_MAM",
                       "moyRA_JJA", "moyRA_SON")
CARD$P.unit_fr = "mm"
CARD$P.name_fr = c("Moyenne des précipitations totales de chaque hiver",
                   "Moyenne des précipitations totales de chaque printemps",
                   "Moyenne des précipitations totales de chaque été",
                   "Moyenne des précipitations totales de chaque automne")
CARD$P.description_fr = c("Mois de décembre, janvier et février",
                          "Mois de mars, avril et mai",
                          "Mois de juin, juillet et août",
                          "Mois de septembre, octobre et novembre")
CARD$P.method_fr = c("1. agrégation annuelle saisonnalisé [01-12, 28(29)-02] - moyenne
2. aucune agrégation temporelle - moyenne",
"1. agrégation annuelle saisonnalisé [01-03, 31-05] - moyenne
2. aucune agrégation temporelle - moyenne",
"1. agrégation annuelle saisonnalisé [01-06, 31-08] - moyenne
2. aucune agrégation temporelle - moyenne",
"1. agrégation annuelle saisonnalisé [01-09, 30-11] - moyenne
2. aucune agrégation temporelle - moyenne")
CARD$P.sampling_period_fr = c("01-12, 28(29)-02",
                              "01-03, 31-05",
                              "01-06, 31-08",
                              "01-09, 30-11")
CARD$P.topic_fr = "Précipitations, Modérée, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(RA=sumNA)
CARD$P1.funct_args = list("R", na.rm=TRUE)
CARD$P1.time_step = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

### P2 _______________________________________________________________
CARD$P2.funct = list(meanRA_DJF=mean, meanRA_MAM=mean, meanRA_JJA=mean, meanRA_SON=mean)
CARD$P2.funct_args = list(list("RA_DJF", na.rm=TRUE), list("RA_MAM", na.rm=TRUE), list("RA_JJA", na.rm=TRUE), list("RA_SON", na.rm=TRUE))
CARD$P2.time_step = "none"

