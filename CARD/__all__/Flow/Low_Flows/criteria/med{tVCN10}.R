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
CARD$P.variable_en = "med{tVCN10}"
CARD$P.unit_en = "yearday"
CARD$P.name_en = "Median of dates of the annual minimum of 10-day mean flows"
CARD$P.description_en = ""
CARD$P.method_en = "1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - date of the minimum
3. no temporal aggregation - median"
CARD$P.sampling_period_en = "Month of maximum monthly flows"
CARD$P.topic_en = "Flow, Low Flow, Seasonality"

### French ___________________________________________________________
CARD$P.variable_fr = "med{tVCN10}"
CARD$P.unit_fr = "jour de l'année"
CARD$P.name_fr = "Médiane des dates du minimum annuel des débits moyens sur 10 jours"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - date du minimum
3. aucune agrégation temporelle - médiane"
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
CARD$P.topic_fr = "Débit, Basses Eaux, Saisonnalité"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 1
CARD$P.is_date = TRUE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(tVCN10=which.minNA)
CARD$P2.funct_args = list("VC10")
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.is_date = TRUE
CARD$P2.NApct_lim = 3

### P3 _______________________________________________________________
CARD$P3.funct = list("med{tVCN10}"=circular_median)
CARD$P3.funct_args = list("tVCN10", periodicity=365.25, na.rm=TRUE)
CARD$P3.time_step = "none"

