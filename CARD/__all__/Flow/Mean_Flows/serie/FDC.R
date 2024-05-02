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
CARD$P.variable_en = "FDC"
CARD$P.unit_en = "m^{3}.s^{-1}"
CARD$P.name_en = "Flow duration curve"
CARD$P.description_en = ""
CARD$P.method_en = "1. no temporal aggregation - flow duration curves with 1000 points spaced according to a centered reduced normal distribution."
CARD$P.topic_en = "Flow, Mean Flows Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "CDC"
CARD$P.unit_fr = "m^{3}.s^{-1}"
CARD$P.name_fr = "Courbe des débits classés"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. aucune agrégation temporelle - courbes des débits classés avec 1000 points espacés selon une loi normale centrée réduite"
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(FDC_p=compute_FDC_p, FDC_Q=compute_FDC_Q)
CARD$P1.funct_args = list(list(n=1000, isNormLaw=TRUE), list("Q", n=1000, isNormLaw=TRUE))
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

