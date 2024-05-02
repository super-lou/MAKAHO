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
CARD$P.variable_en = paste0("delta{dtBF}_", Horizon)
CARD$P.unit_en = "day"
CARD$P.name_en = paste0("Average change of the duration of low flows between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = paste0("Duration between the start and end of low flows")
CARD$P.method_en = paste0("1. annual aggregation [09-01, 08-31] - number of days between the dates when the baseflow (Wallingford) sum corresponds to 10 % and 90 % of the total sum
2. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Baseflow, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta{dtQB}_", Horizon)
CARD$P.unit_fr = "jour"
CARD$P.name_fr = paste0("Changement moyen de la durée des écoulements lents entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = paste0("Durée entre le début et la fin des écoulements lents")
CARD$P.method_fr = paste0("1. agrégation annuelle [01-09, 31-08] - nombre de jours entre les dates auxquelles la somme du débit de base (Wallingford) correspond à 10 % et 90 % de la somme totale
2. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit, Débit de Base, Durée"

### Global ___________________________________________________________
CARD$P.source = "TALLAKSEN, L. et H. VAN LANEN, éd. (2004). Hydrological drought. Processes and estimation methods for streamflow and groundwater. English. Developments in water science 48. Netherlands : Elsevier. ISBN : 9780444516886."
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(dtBF=compute_tSnowmelt)
CARD$P1.funct_args = list("Q", p1=0.1, p2=0.9, method="Wal")
CARD$P1.time_step = "year"
CARD$P1.sampling_period = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list("delta{dtBF}_H1"=get_deltaX,
                     "delta{dtBF}_H2"=get_deltaX,
                     "delta{dtBF}_H3"=get_deltaX)
CARD$P2.funct_args = list(list("dtBF", "date",
                               past=H0, futur=H1,
                               to_normalise=CARD$P.to_normalise),
                          list("dtBF", "date",
                               past=H0, futur=H2,
                               to_normalise=CARD$P.to_normalise),
                          list("dtBF", "date",
                               past=H0, futur=H3,
                               to_normalise=CARD$P.to_normalise))
CARD$P2.time_step = "none"
