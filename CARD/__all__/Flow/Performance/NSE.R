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
CARD$P.variable_en = "NSE"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Nash-Sutcliffe Efficiency"
CARD$P.description_en = "It measures the proximity between the reference data series and the simulated ones, based on the square deviation. The coefficient gives strong emphasis on the reconstruction of high values of the examined variable."
CARD$P.method_en = "1. no temporal aggregation - NSE calculation"
CARD$P.topic_en = "Flow, Performance"

### French ___________________________________________________________
CARD$P.variable_fr = "NSE"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Coefficient d’efficience de Nash-Sutcliffe"
CARD$P.description_fr = "Il mesure la proximité entre les séries de données de référence et celles simulées, sur la base de l’écart quadratique. Le coefficient donne un poids fort à la reconstitution des valeurs fortes de la variable examinée."
CARD$P.method_fr = "1. aucune agrégation temporelle - calcul du NSE"
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.source = "NASH, J. E. et J. V. SUTCLIFFE (1970). « River flow forecasting through conceptual models part I — A discussion of principles ». In : Journal of Hydrology 10.3, p. 282-290. DOI : 10.1016/0022-1694(70)90255-6."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(NSE=compute_NSE)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

