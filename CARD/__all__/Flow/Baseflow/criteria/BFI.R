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
CARD$P.variable_en = "BFI_Wal"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Baseflow index"
CARD$P.description_en = "Ratio between mean inter-annual base flow and mean inter-annual flow"
CARD$P.method_en = "1. no temporal aggregation - extraction of the base flow (Wallingford)
2. no temporal aggregation - calculation of the Base Flow Index (BFI)"
CARD$P.topic_en = "Flow, Base Flow, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = "BFI_Wal"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Indice de débit de base"
CARD$P.description_fr = "Rapport entre débit de base moyen inter-annuel et débit moyen inter-annuel"
CARD$P.method_fr = "1. aucune agrégation temporelle - extraction du débit de base (Wallingford)
2. aucune agrégation temporelle - calcul du BFI"
CARD$P.topic_fr = "Débit, Débit de Base, Intensité"

### Global ___________________________________________________________
CARD$P.source = "TALLAKSEN, L. et H. VAN LANEN, éd. (2004). Hydrological drought. Processes and estimation methods for streamflow and groundwater. English. Developments in water science 48. Netherlands : Elsevier. ISBN : 9780444516886."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(BF_Wal=BFS)
CARD$P1.funct_args = list("Q", method="Wal")
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(BFI_Wal=get_BFI)
CARD$P2.funct_args = list("Q", "BF_Wal")
CARD$P2.time_step = "none"

