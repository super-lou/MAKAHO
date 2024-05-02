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
CARD$P.variable_en = paste0("deltaQ99A_", Horizon)
CARD$P.unit_en = "%"
CARD$P.name_en = paste0("Average change of annual flow exceeded 99 years out of 100 between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = "Annual flow with a exceedance probability of 99 % (1th percentile)"
CARD$P.method_en = paste0("1. annual aggregation [01-01, 12-31] - quantile at the exceedance probability of 99 %
2. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "01-01, 12-31"
CARD$P.topic_en = "Flow, Low Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("deltaQ99A_", Horizon)
CARD$P.unit_fr = "%"
CARD$P.name_fr = paste0("Changement moyen du débit annuel dépassée 99 années sur 100 entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = "Débit annuel avec une probabilité de dépassement de 99 % (centile 1 %)"
CARD$P.method_fr = paste0("1. agrégation annuelle [01-01, 31-12] - quantile à la probabilité au dépassement de 99 %
2. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "01-01, 31-12"
CARD$P.topic_fr = "Débit, Basses Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(Q99A=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.99)
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "01-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("deltaQ99A_H1"=get_deltaX,
                     "deltaQ99A_H2"=get_deltaX,
                     "deltaQ99A_H3"=get_deltaX)
CARD$P2.funct_args = list(list("Q99A", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("Q99A", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("Q99A", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P2.time_step = "none"
