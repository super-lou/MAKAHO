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
CARD$P.variable_en = paste0("delta",
                            rep(c("QSA_DJF", "QSA_MAM", "QSA_JJA", "QSA_SON"),
                                each=3), "_", Horizon)
CARD$P.unit_en = "%"
CARD$P.name_en = paste0("Average change of ",
                        rep(c("average daily flows for each winter",
                              "average daily flows for each spring",
                              "average daily flows for each summer",
                              "average daily flows for each autumn"),
                            each=3),
                        " between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = rep(c("Months of December, January, and February",
                              "Months of March, April, and May",
                              "Months of June, July, and August",
                              "Months of September, October, and November"), each=3)
CARD$P.method_en = paste0(rep(c("1. seasonal annual aggregation [12-01, 02-28(29)] - mean",
                                "1. seasonal annual aggregation [03-01, 05-31] - mean",
                                "1. seasonal annual aggregation [06-01, 08-31] - mean",
                                "1. seasonal annual aggregation [09-01, 11-30] - mean"),
                              each=3),
                          "\n2. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = rep(c("12-01, 02-28(29)",
                                  "03-01, 05-31",
                                  "06-01, 08-31",
                                  "09-01, 11-30"), each=3)
CARD$P.topic_en = "Flow, Mean Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta",
                            rep(c("QSA_DJF", "QSA_MAM", "QSA_JJA", "QSA_SON"),
                                each=3), "_", Horizon)
CARD$P.unit_fr = "%"
CARD$P.name_fr = paste0("Changement moyen de la ",
                        rep(c("moyenne des débits journaliers de chaque hiver",
                              "moyenne des débits journaliers de chaque printemps",
                              "moyenne des débits journaliers de chaque été",
                              "moyenne des débits journaliers de chaque automne"),
                            each=3),
                        " entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = rep(c("Mois de décembre, janvier et février",
                              "Mois de mars, avril et mai",
                              "Mois de juin, juillet et août",
                              "Mois de septembre, octobre et novembre"), each=3)
CARD$P.method_fr = paste0(rep(c("1. agrégation annuelle saisonnalisé [01-12, 28(29)-02] - moyenne",
                                "1. agrégation annuelle saisonnalisé [01-03, 31-05] - moyenne",
                                "1. agrégation annuelle saisonnalisé [01-06, 31-08] - moyenne",
                                "1. agrégation annuelle saisonnalisé [01-09, 30-11] - moyenne"),
                              each=3),
                          "\n2. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = rep(c("01-12, 28(29)-02",
                                  "01-03, 31-05",
                                  "01-06, 31-08",
                                  "01-09, 30-11"), each=3)
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QSA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

### P2 _______________________________________________________________
CARD$P2.funct = replicate(12, get_deltaX, simplify=FALSE)
names(CARD$P2.funct) = paste0(rep(paste0("deltaQSA_", CARD$P1.Seasons),
                                  each=3), "_", Horizon)

variable = rep(paste0("QSA_", CARD$P1.Seasons), each=3)
HX = rep(Horizon, 4)
CARD$P2.funct_args = replicate(12,
                               list("variable", "date",
                                    past=H0, futur="HX",
                                    to_normalise=CARD$P.to_normalise),
                               simplify=FALSE)
for (i in 1:length(CARD$P2.funct_args)) {
    CARD$P2.funct_args[[i]][1] = variable[i]
    CARD$P2.funct_args[[i]]$futur = get(HX[i])
}

CARD$P2.time_step = "none"
