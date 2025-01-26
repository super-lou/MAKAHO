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
CARD$P.variable_en = paste0("deltaQJXA-10_", Horizon)
CARD$P.unit_en = "%"
CARD$P.name_en = paste0("Change of annual maximum daily flow with a 10-year return period between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = ""
CARD$P.method_en = paste0("1. annual aggregation [Month of minimum monthly flows] - maximum (extraction from the QJXA series)
2. no temporal aggregation - calculation of the 10-year return period flow with the Gumbel distribution on the historical period and in the ", Horizon_en, " horizon then calculation of the average change")
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("deltaQJXA-10_", Horizon)
CARD$P.unit_fr = "%"
CARD$P.name_fr = paste0("Changement du débit journalier maximal annuel de période de retour 10 ans entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = ""
CARD$P.method_fr = paste0("1. agrégation annuelle [Mois du minimum des débits mensuels] - maximum (extraction de la série des QJXA)
2. aucune agrégation temporelle - calcul du débit de période de retour 10 ans avec la loi de Gumbel sur la période historique et en horizon ", Horizon_fr, " puis calcul du changement moyen")
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Intensity"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QJXA=maxNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year"
CARD$P1.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("deltaQJXA-10_H1"=get_deltaX,
                     "deltaQJXA-10_H2"=get_deltaX,
                     "deltaQJXA-10_H3"=get_deltaX)
CARD$P2.funct_args = list(list("QJXA", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise,
                               returnPeriod=10, waterType="high"),
                          
                          list("QJXA", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise,
                               returnPeriod=10, waterType="high"),
                          
                          list("QJXA", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise,
                               returnPeriod=10, waterType="high"))
CARD$P2.time_step = "none"
