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
CARD$P.variable_en = "NSEsqrt"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Nash-Sutcliffe Efficiency of the square root of the data"
CARD$P.description_en = "Identical to NSE, this score, however, gives equal weight across the entire range of the evaluated variable."
CARD$P.method_en = "1. no temporal aggregation - square root of simulated and reference data, then NSE"
CARD$P.topic_en = "Flow, Performance"

### French ___________________________________________________________
CARD$P.variable_fr = "NSEracine"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Coefficient d’efficience de Nash-Sutcliffe de la racine carrée des données"
CARD$P.description_fr = "Identique au NSE, ce score donne cependant un poids équivalent sur l’ensemble de la plage de variation de la variable évaluée."
CARD$P.method_fr = "1. aucune agrégation temporelle - racine carrée des données simulées et de référence puis NSE"
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.source = "NASH, J. E. et J. V. SUTCLIFFE (1970). « River flow forecasting through conceptual models part I — A discussion of principles ». In : Journal of Hydrology 10.3, p. 282-290. DOI : 10.1016/0022-1694(70)90255-6."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(NSEsqrt=compute_NSEracine)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

