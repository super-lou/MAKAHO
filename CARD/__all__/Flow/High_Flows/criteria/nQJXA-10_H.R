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
CARD$P.variable_en = paste0("nQJXA-10_", Horizon)
CARD$P.unit_en = "without unit"
CARD$P.name_en = paste0("Number of years in the ", Horizon_en, " horizon where QJXA is superior to QJXA-10 from the historical period")
CARD$P.description_en = ""
CARD$P.method_en = paste0("1. annual aggregation [Month of minimum monthly flows] - maximum (extraction from the QJXA series)
2. no temporal aggregation - calculation of the flow with a 10-year return period using the Gumbel distribution from the historical period (QJXA-10_H0)
3. no temporal aggregation - counting the number of QJXA in the ", Horizon_en, " horizon above QJXA-10_H0")
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Occurrence"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("nQJXA-10_", Horizon)
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = paste0("Nombre d'années de l'horizon ", Horizon_fr, " où le QJXA est supérieur au QJXA-10 de la période historique")
CARD$P.description_fr = ""
CARD$P.method_fr = paste0("1. agrégation annuelle [Mois du minimum des débits mensuels] - maximum (extraction de la série des QJXA)
2. aucune agrégation temporelle - calcul du débit de période de retour 10 ans avec la loi de Gumbel sur la période historique (QJXA-10_H0)
3. aucune agrégation temporelle - décompte du nombre de QJXA de l'horizon ", Horizon_fr, " au dessus du QJXA-10_H0")
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Occurrence"

### Global ___________________________________________________________
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
CARD$P2.funct = list("QJXA-10_H0"=get_Xn)
CARD$P2.funct_args = list("QJXA", returnPeriod=10, waterType="high",
                          Date="date", period=H0)
CARD$P2.time_step = "none"
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list("nQJXA-10_H1"=apply_threshold,
                     "nQJXA-10_H2"=apply_threshold,
                     "nQJXA-10_H3"=apply_threshold)

CARD$P3.funct_args = list(list("QJXA", lim="QJXA-10_H0", where=">=",
                               what="length", select="all",
                               Date="date", period=H1),

                          list("QJXA", lim="QJXA-10_H0", where=">=",
                               what="length", select="all",
                               Date="date", period=H2),
                          
                          list("QJXA", lim="QJXA-10_H0", where=">=",
                               what="length", select="all",
                               Date="date", period=H3))
CARD$P3.time_step = "none"
