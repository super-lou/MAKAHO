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
CARD$P.variable_en = "meanQA"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "Average of annual average daily flow"
CARD$P.description_en = ""
CARD$P.method_en = "1. annual aggregation [09-01, 08-31] - mean
2. no temporal aggregation - average"
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Average Waters, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "moyQA"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Moyenne des moyennes annuelles du débit journalier"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation annuelle [01-09, 31-08] - moyenne
2. aucune agrégation temporelle - moyenne"
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("meanQA"=mean)
CARD$P2.funct_args = list("QA", na.rm=TRUE)
CARD$P2.time_step = "none"

