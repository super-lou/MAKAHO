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
CARD$P.variable_en = "QMNA_summer"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "Summer minimum of monthly flows"
CARD$P.description_en = ""
CARD$P.method_en = "1. monthly aggregation - mean
2. annual aggregation [05-01, 11-30] - minimum"
CARD$P.sampling_period_en = "05-01, 11-30"
CARD$P.topic_en = "Flow, Low Flow, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "QMNA_été"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Minimum estival des débits mensuels"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation mensuelle - moyenne
2. agrégation annuelle [01-05, 30-11] - minimum"
CARD$P.sampling_period_fr = "01-05, 30-11"
CARD$P.topic_fr = "Débit, Basses Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QMA_summer=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(QMNA_summer=minNA)
CARD$P2.funct_args = list("QMA_summer", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = c("05-01", "11-30")
CARD$P2.NApct_lim = 3

