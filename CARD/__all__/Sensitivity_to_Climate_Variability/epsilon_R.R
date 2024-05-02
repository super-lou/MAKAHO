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
CARD$P.variable_en = "epsilon_R"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Annual flow elasticity to precipitation"
CARD$P.description_en = ""
CARD$P.method_en = "1. annual aggregation [Month of minimum monthly flows] - mean flow and mean total precipitation
2. no temporal aggregation - calculation of elasticity ε"
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow / Precipitations, Sensitivity to Climate Variability"

### French ___________________________________________________________
CARD$P.variable_fr = "epsilon_R"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Élasticité annuelle du débit aux précipitations"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation annuelle [Mois du minimum des débits mensuels] - débit moyen et précipitations totales moyennes
2. aucune agrégation temporelle - calcul de l’élasticité ε"
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit / Précipitations, Sensibilité à la variabilité climatique"

### Global ___________________________________________________________
CARD$P.source = "SANKARASUBRAMANIAN, A., R. M. VOGEL et J. F. LIMBRUNNER (1991). « Climate elasticity of streamflow in the United States ». In : Water Resour. Res. 37, p. 1771-1781."
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QA=mean, RA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE), list("R", na.rm=TRUE))
CARD$P1.time_step = "year"
CARD$P1.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("epsilon_R"=compute_elasticity)
CARD$P2.funct_args = list(Q="QA", X="RA")
CARD$P2.time_step = "none"
CARD$P2.NApct_lim = 3

