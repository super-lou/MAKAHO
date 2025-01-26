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
CARD$P.variable_en = "med{dtFlood}"
CARD$P.unit_en = "day"
CARD$P.name_en = "Median duration of floods"
CARD$P.description_en = "Median of the durations of floods sampled by annual maxima"
CARD$P.method_en = "1. no temporal aggregation - Qr difference between daily flow values and base flow
2. annual aggregation [Month of minimum monthly flows] - maximum of Qr
3. annual aggregation [Month of minimum monthly flows] - division by two of annual maxima to obtain a threshold
4. annual aggregation [Month of minimum monthly flows] - number of days where the difference is greater than the threshold
5. no temporal aggregation - median"
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = "med{dtCrue}"
CARD$P.unit_fr = "jour"
CARD$P.name_fr = "Durée médiane des crues"
CARD$P.description_fr = "Médiane des durées des crues échantillonnées par maxima annuel"
CARD$P.method_fr = "1. aucune agrégation temporelle - différence Qr entre les valeurs journalières de débit par le débit de base
2. agrégation annuelle [Mois du minimum des débits mensuels] - maximum de Qr
3. agrégation annuelle [Mois du minimum des débits mensuels] - division par deux des maxima annuels pour obtenir un seuil
4. agrégation annuelle [Mois du minimum des débits mensuels] - nombre de jours où la différence est supérieure au seuil
5. aucune agrégation temporelle - médiane"
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Durée"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(dQ=dBFS)
CARD$P1.funct_args = list("Q")
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(dQXA=maxNA)
CARD$P2.funct_args = list("dQ", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(lowLim=divided)
CARD$P3.funct_args = list("dQXA", 2, first=TRUE)
CARD$P3.time_step = "year"
CARD$P3.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(dtFlood=apply_threshold)
CARD$P4.funct_args = list("dQ", lim="lowLim", where=">=", what="length", select="dQXA")
CARD$P4.time_step = "year"
CARD$P4.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P4.NApct_lim = 3

### P5 _______________________________________________________________
CARD$P5.funct = list("med{dtFlood}"=median)
CARD$P5.funct_args = list("dtFlood", na.rm=TRUE)
CARD$P5.time_step = "none"

