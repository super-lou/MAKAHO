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


Horizon = c("H1", "H2", "H3")
Horizon_en = c("near", "middle", "distant")
Horizon_fr = c("proche", "moyen", "lointain")
H0 = c("1976-01-01", "2005-08-31")
H1 = c("2021-01-01", "2050-12-31")
H2 = c("2041-01-01", "2070-12-31")
H3 = c("2070-01-01", "2099-12-31")


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = paste0("delta{tVCN10}_", Horizon)
CARD$P.unit_en = "day"
CARD$P.name_en = paste0("Average change of the date of the annual minimum of 10-day mean flows between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = ""
CARD$P.method_en = paste0("1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - date of the minimum
3. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "Month of maximum monthly flows"
CARD$P.topic_en = "Flow, Low Flows, Seasonality"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{tVCN10}_", Horizon)
CARD$P.unit_fr = "jour"
CARD$P.name_fr = paste0("Changement moyen de la date du minimum annuel des débits moyens sur 10 jours entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = ""
CARD$P.method_fr = paste0("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - date du minimum
3. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
CARD$P.topic_fr = "Débit, Basses Eaux, Saisonnalité"

### Global ___________________________________________________________
CARD$P.is_date = TRUE
CARD$P.to_normalise = FALSE
CARD$P.palette = "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(tVCN10=which.minNA)
CARD$P2.funct_args = list("VC10")
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.is_date = TRUE
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10

### P3 _______________________________________________________________
CARD$P3.funct = list("delta{tVCN10}_H1"=get_deltaX,
                     "delta{tVCN10}_H2"=get_deltaX,
                     "delta{tVCN10}_H3"=get_deltaX)
CARD$P3.funct_args = list(list("tVCN10", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("tVCN10", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("tVCN10", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P3.time_step = "none"
