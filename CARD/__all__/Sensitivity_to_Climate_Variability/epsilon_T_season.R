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
CARD$P.variable_en = c("epsilon_T_DJF", "epsilon_T_MAM",
                       "epsilon_T_JJA", "epsilon_T_SON")
CARD$P.unit_en = "without unit"
CARD$P.name_en = c("Winter flow elasticity to air temperatures",
                   "Spring flow elasticity to air temperatures",
                   "Summer flow elasticity to air temperatures",
                   "Autumn flow elasticity to air temperatures")
CARD$P.description_en = c("Months of December, January, and February",
                          "Months of March, April, and May",
                          "Months of June, July, and August",
                          "Months of September, October, and November")
CARD$P.method_en = c("1. seasonal annual aggregation [12-01, 02-28(29)] - mean flow and mean temperatures
2. no temporal aggregation - calculation of elasticity ε",
"1. seasonal annual aggregation [03-01, 05-31] - mean flow and mean temperatures
2. no temporal aggregation - calculation of elasticity ε",
"1. seasonal annual aggregation [06-01, 08-31] - mean flow and mean temperatures
2. no temporal aggregation - calculation of elasticity ε",
"1. seasonal annual aggregation [09-01, 11-30] - mean flow and mean temperatures
2. no temporal aggregation - calculation of elasticity ε")
CARD$P.sampling_period_en = c("12-01, 02-28(29)",
                              "03-01, 05-31",
                              "06-01, 08-31",
                              "09-01, 11-30")
CARD$P.topic_en = "Flow / Temperature, Sensitivity to Climate Variability"


### French ___________________________________________________________
CARD$P.variable_fr = c("epsilon_T_DJF", "epsilon_T_MAM",
                       "epsilon_T_JJA", "epsilon_T_SON")
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = c("Élasticité hivernale du débit aux températures de l’air",
                   "Élasticité printanière du débit aux températures de l’air",
                   "Élasticité estivale du débit aux températures de l’air",
                   "Élasticité automnale du débit aux températures de l’air")
CARD$P.description_fr = c("Mois de décembre, janvier et février",
                          "Mois de mars, avril et mai",
                          "Mois de juin, juillet et août",
                          "Mois de septembre, octobre et novembre")
CARD$P.method_fr = c("1. agrégation annuelle saisonnalisée [01-12, 28(29)-02] - débit moyen et températures moyennes
2. aucune agrégation temporelle - calcul de l’élasticité ε",
"1. agrégation annuelle saisonnalisée [01-03, 31-05] - débit moyen et températures moyennes
2. aucune agrégation temporelle - calcul de l’élasticité ε",
"1. agrégation annuelle saisonnalisée [01-06, 31-08] - débit moyen et températures moyennes
2. aucune agrégation temporelle - calcul de l’élasticité ε",
"1. agrégation annuelle saisonnalisée [01-09, 30-11] - débit moyen et températures moyennes
2. aucune agrégation temporelle - calcul de l’élasticité ε")
CARD$P.sampling_period_fr = c("01-12, 28(29)-02",
                              "01-03, 31-05",
                              "01-06, 31-08",
                              "01-09, 30-11")
CARD$P.topic_fr = "Débit / Température, Sensibilité à la variabilité climatique"

### Global ___________________________________________________________
CARD$P.source = "SANKARASUBRAMANIAN, A., R. M. VOGEL et J. F. LIMBRUNNER (1991). « Climate elasticity of streamflow in the United States ». In : Water Resour. Res. 37, p. 1771-1781."
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QA=mean, TA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE), list("T", na.rm=TRUE))
CARD$P1.time_step = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

### P2 _______________________________________________________________
CARD$P2.funct = list("epsilon_T_DJF"=compute_elasticity, "epsilon_T_MAM"=compute_elasticity, "epsilon_T_JJA"=compute_elasticity, "epsilon_T_SON"=compute_elasticity)
CARD$P2.funct_args = list(list(Q="QA_DJF", X="TA_DJF"), list(Q="QA_MAM", X="TA_MAM"), list(Q="QA_JJA", X="TA_JJA"), list(Q="QA_SON", X="TA_SON"))
CARD$P2.time_step = "none"

