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
CARD$P.variable_en = "med{startBF}"
CARD$P.unit_en = "yearday"
CARD$P.name_en = "Median start of baseflow"
CARD$P.description_en = "Median of the dates at which 10 % of the annual cumulative baseflow is reached"
CARD$P.method_en = "1. annual aggregation [09-01, 08-31] - date at which the baseflow (Wallingford) sum corresponds to 10 % of the total sum
2. no temporal aggregation - median"
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Baseflow, Seasonality"

### French ___________________________________________________________
CARD$P.variable_fr = "med{debutQB}"
CARD$P.unit_fr = "jour de l'année"
CARD$P.name_fr = "Médiane du début des écoulements lents"
CARD$P.description_fr = "Médiane des dates à laquelle 10 % du cumul annuel du débit de base sont atteints"
CARD$P.method_fr = "1. agrégation annuelle [01-09, 31-08] - date à laquelle la somme du débit de base (Wallingford) correspond à 10 % de la somme totale
2. aucune agrégation temporelle - médiane"
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit, Débit de Base, Saisonnalité"

### Global ___________________________________________________________
CARD$P.source = "TALLAKSEN, L. et H. VAN LANEN, éd. (2004). Hydrological drought. Processes and estimation methods for streamflow and groundwater. English. Developments in water science 48. Netherlands : Elsevier. ISBN : 9780444516886."
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = TRUE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(startBF=compute_tVolSnowmelt)
CARD$P1.funct_args = list("Q", p=0.1, method="Wal")
CARD$P1.time_step = "year"
CARD$P1.sampling_period = '09-01'
CARD$P1.is_date = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("med{startBF}"=circular_median)
CARD$P2.funct_args = list("startBF", periodicity=365.25, na.rm=TRUE)
CARD$P2.time_step = "none"

