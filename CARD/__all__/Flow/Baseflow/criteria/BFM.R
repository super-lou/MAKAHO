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
CARD$P.variable_en = "BFM"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Baseflow magnitude"
CARD$P.description_en = ""
CARD$P.method_en = "1. no temporal aggregation - extraction of the base flow (Wallingford)
2. aggregation by day of the year - average of the base flow BFA
3. no temporal aggregation - calculation of the base flow magnitude BFM"
CARD$P.topic_en = "Flow, Base Flow, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "BFM"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Magnitude du débit de base"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. aucune agrégation temporelle - extraction du débit de base (Wallingford)
2. agrégation par jour de l’année - moyenne du débit de base BFA
3. aucune agrégation temporelle - calcul du BFM"
CARD$P.topic_fr = "Débit, Débit de Base, Intensité"

### Global ___________________________________________________________
CARD$P.source = "TALLAKSEN, L. et H. VAN LANEN, éd. (2004). Hydrological drought. Processes and estimation methods for streamflow and groundwater. English. Developments in water science 48. Netherlands : Elsevier. ISBN : 9780444516886."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(BF=BFS)
CARD$P1.funct_args = list("Q", method="Wal")
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(BFA=mean)
CARD$P2.funct_args = list("BF", na.rm=TRUE)
CARD$P2.time_step = "yearday"
CARD$P2.NApct_lim = 3

### P3 _______________________________________________________________
CARD$P3.funct = list(BFM=get_BFM)
CARD$P3.funct_args = list("BFA")
CARD$P3.time_step = "none"

