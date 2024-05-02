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
CARD$P.variable_en = paste0("nVCN10-5_", Horizon)
CARD$P.unit_en = "without unit"
CARD$P.name_en = paste0("Number of years in the ", Horizon_en, " horizon where VCN10 is superior to VCN10-5 from the historical period")
CARD$P.description_en = ""
CARD$P.method_en = paste0("1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum (VCN10)
3. no temporal aggregation - calculation of the 5-year return period flow with the log-normal distribution from the historical period (VCN10-5_H0)
4. no temporal aggregation - counting the number of VCN10 in the ", Horizon_en, " horizon above VCN10-5_H0")
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, Low Flows, Occurrence"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("nVCN10-5_", Horizon)
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = paste0("Nombre d'années de l'horizon ", Horizon_fr, " où le VCN10 est supérieur au VCN10-5 de la période historique")
CARD$P.description_fr = ""
CARD$P.method_fr = paste0("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (VCN10)
3. aucune agrégation temporelle - calcul du débit de période de retour 5 ans avec la loi log-normal sur la période historique (VCN10-5_H0)
4. aucune agrégation temporelle - décompte du nombre de VCN10 de l'horizon ", Horizon_fr, " au dessus du VCN10-5_H0")
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Basses Eaux, Occurrence"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3

### P3 _______________________________________________________________
CARD$P3.funct = list("VCN10-5_H0"=get_Xn)
CARD$P3.funct_args = list("VCN10", returnPeriod=5, waterType="low",
                          Date="date", period=H0)
CARD$P3.time_step = "none"
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list("nVCN10-5_H1"=apply_threshold,
                     "nVCN10-5_H2"=apply_threshold,
                     "nVCN10-5_H3"=apply_threshold)

CARD$P4.funct_args = list(list("VCN10", lim="VCN10-5_H0", where="<=",
                               what="length", select="all",
                               Date="date", period=H1),

                          list("VCN10", lim="VCN10-5_H0", where="<=",
                               what="length", select="all",
                               Date="date", period=H2),
                          
                          list("VCN10", lim="VCN10-5_H0", where="<=",
                               what="length", select="all",
                               Date="date", period=H3))
CARD$P4.time_step = "none"
