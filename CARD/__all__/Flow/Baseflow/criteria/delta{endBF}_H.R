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
CARD$P.variable_en = paste0("delta{endBF}_", Horizon)
CARD$P.unit_en = "day"
CARD$P.name_en = paste0("Average change of the end of Base Flow between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = paste0("Date when 90 % of the annual cumulative base flow is reached")
CARD$P.method_en = paste0("1. annual aggregation [09-01, 08-31] - date when the sum of base flow (Wallingford) Qb corresponds to 90 % of the total sum
2. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Base Flow, Seasonality"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{finQB}_", Horizon)
CARD$P.unit_fr = "jour"
CARD$P.name_fr = paste0("Changement moyen de la fin des écoulements lents entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = paste0("Date à laquelle 90 % du cumul annuel du débit de base sont atteints")
CARD$P.method_fr = paste0("1. agrégation annuelle [01-09, 31-08] - date à laquelle la somme du débit de base (Wallingford) Qb correspond à 90 % de la somme totale
2. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit, Débit de Base, Saisonnalité"

### Global ___________________________________________________________
CARD$P.source = "TALLAKSEN, L. et H. VAN LANEN, éd. (2004). Hydrological drought. Processes and estimation methods for streamflow and groundwater. English. Developments in water science 48. Netherlands : Elsevier. ISBN : 9780444516886."
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = TRUE
CARD$P.to_normalise = FALSE
CARD$P.palette = "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(endBF=compute_tVolSnowmelt)
CARD$P1.funct_args = list("Q", p=0.9, method="Wal")
CARD$P1.time_step = "year"
CARD$P1.sampling_period = '09-01'
CARD$P1.is_date = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("delta{endBF}_H1"=get_deltaX,
                     "delta{endBF}_H2"=get_deltaX,
                     "delta{endBF}_H3"=get_deltaX)
CARD$P2.funct_args = list(list("endBF", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("endBF", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("endBF", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P2.time_step = "none"
