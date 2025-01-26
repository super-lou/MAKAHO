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
CARD$P.variable_en = paste0("delta{fQ01A}_", Horizon)
CARD$P.unit_en = "day.year^{-1}"
CARD$P.name_en = paste0("Average change of the annual frequency of exceeding Q01 between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = paste0("Annual frequency of exceeding Q > Q01, where Q01 is the flow exceeded 1 % of the time, extracted from the ranked flow curve")
CARD$P.method_en = paste0("1. no temporal aggregation - the quantile at the 1 % exceedance probability is taken as the threshold
2. annual aggregation [Month of minimum monthly flows] - ratio of the number of days with flow exceeding the threshold to the number of days in the year
3. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Frequency"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{fQ01A}_", Horizon)
CARD$P.unit_fr = "jour.an^{-1}"
CARD$P.name_fr = paste0("Changement moyen de la fréquence annuelle de dépassement du Q01 entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = paste0("Fréquence annuelle de dépassement de Q > Q01, Q01 est le débit dépassé 1 % du temps, extrait de la courbe des débits classés")
CARD$P.method_fr = paste0("1. aucune agrégation temporelle - le quantile à la probabilité au dépassement de 1 % est pris comme seuil
2. agrégation annuelle [Mois du minimum des débits mensuels] - rapport du nombre de jours où le débit dépasse le seuil par le nombre de jours dans l’année
3. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Fréquence"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(lowLim=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.01)
CARD$P1.time_step = "none"
CARD$P1.NApct_lim = NULL
CARD$P1.NAyear_lim = 10
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(fQ01A=compute_fAp)
CARD$P2.funct_args = list("Q", lowLim="lowLim")
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3

### P3 _______________________________________________________________
CARD$P3.funct = list("delta{fQ01A}_H1"=get_deltaX,
                     "delta{fQ01A}_H2"=get_deltaX,
                     "delta{fQ01A}_H3"=get_deltaX)
CARD$P3.funct_args = list(list("fQ01A", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("fQ01A", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("fQ01A", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P3.time_step = "none"
