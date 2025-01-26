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
CARD$P.variable_en = "Q10"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "Flow exceeded 1 year in 10"
CARD$P.description_en = "Flow with an exceedance probability of 10 % (90th percentile)"
CARD$P.method_en = "1. no temporal aggregation - quantile at the exceedance probability of 10 %"
CARD$P.topic_en = "Flow, High Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "Q10"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Débit dépassée 1 années sur 10"
CARD$P.description_fr = "Débit avec une probabilité de dépassement de 10 % (centile 90 %)"
CARD$P.method_fr = "1. aucune agrégation temporelle - quantile à la probabilité de dépassement de 10 %"
CARD$P.topic_fr = "Débit, Hautes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 1
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(Q10=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.1)
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

