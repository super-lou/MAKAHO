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
CARD$P.variable_en = paste0("delta{BFI}_Wal_", Horizon)
CARD$P.unit_en = "without unit"
CARD$P.name_en = paste0("Change of baseflow index between the ", Horizon_en, " horizon and historical period (Wallingford)")
CARD$P.description_en = paste0("Ratio between mean inter-annual base flow and mean inter-annual flow")
CARD$P.method_en = paste0("1. no temporal aggregation - extraction of the base flow (Wallingford)
2. no temporal aggregation - calculation of the BFI change between the historical period and the ", Horizon_en, " horizon")
CARD$P.topic_en = "Flow, Base Flow, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{BFI}_Wal_", Horizon)
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = paste0("Changement de l'indice de débit de base entre l'horizon ", Horizon_fr, " et la période historique (Wallingford)")
CARD$P.description_fr = paste0("Rapport entre débit de base moyen inter-annuel et débit moyen inter-annuel")
CARD$P.method_fr = paste0("1. aucune agrégation temporelle - extraction du débit de base (Wallingford)
2. aucune agrégation temporelle - calcul du changement de BFI entre la période historique et l'horizon ", Horizon_fr)
CARD$P.topic_fr = "Débit, Débit de Base, Intensité"

### Global ___________________________________________________________
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
CARD$P2.funct = list("delta{BFI}_Wal_H1"=get_deltaX,
                     "delta{BFI}_Wal_H2"=get_deltaX,
                     "delta{BFI}_Wal_H3"=get_deltaX)
CARD$P2.funct_args = list(list("BF_Wal", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise,
                               Q_for_BFI="Q"),
                          list("BF_Wal", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise,
                               Q_for_BFI="Q"),
                          list("BF_Wal", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise,
                               Q_for_BFI="Q"))
CARD$P2.time_step = "none"
