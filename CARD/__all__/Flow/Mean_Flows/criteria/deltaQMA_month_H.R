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

Months = c("jan", "feb", "mar", "apr", "may", "jun",
           "jul", "aug", "sep", "oct", "nov", "dec")


## INFO ______________________________________________________________
### English __________________________________________________________
CARD$P.variable_en = paste0("delta",
                            rep(c("QMA_jan", "QMA_feb", "QMA_mar",
                                  "QMA_apr", "QMA_may", "QMA_jun",
                                  "QMA_jul", "QMA_aug", "QMA_sep",
                                  "QMA_oct", "QMA_nov", "QMA_dec"),
                                each=3), "_", Horizon)
CARD$P.unit_en = "%"
CARD$P.name_en = paste0("Average change of ",
                        rep(c("average daily discharge for each January",
                              "average daily discharge for each February",
                              "average daily discharge for each March",
                              "average daily discharge for each April",
                              "average daily discharge for each May",
                              "average daily discharge for each June",
                              "average daily discharge for each July",
                              "average daily discharge for each August",
                              "average daily discharge for each September",
                              "average daily discharge for each October",
                              "average daily discharge for each November",
                              "average daily discharge for each December"),
                            each=3),
                        " between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = ""
CARD$P.method_en = ""
CARD$P.sampling_period_en = rep(c("01-01, 01-31", "02-01, 02-28(29)", "03-01, 03-31",
                                  "04-01, 04-30", "05-01, 05-31", "06-01, 06-30",
                                  "07-01, 07-31", "08-01, 08-31", "09-01, 09-30",
                                  "10-01, 10-31", "11-01, 11-30", "12-01, 12-31"),
                                each=3)
CARD$P.topic_en = "Flow, Mean Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta",
                            rep(c("QMA_janv", "QMA_fevr", "QMA_mars",
                                  "QMA_avril", "QMA_mai", "QMA_juin",
                                  "QMA_juil", "QMA_aout", "QMA_sept",
                                  "QMA_oct", "QMA_nov", "QMA_dec"),
                                each=3), "_", Horizon)
CARD$P.unit_fr = "%"
CARD$P.name_fr = paste0("Changement moyen de la ",
                        rep(c("moyenne des débits journaliers de chaque janvier",
                              "moyenne des débits journaliers de chaque février",
                              "moyenne des débits journaliers de chaque mars",
                              "moyenne des débits journaliers de chaque avril",
                              "moyenne des débits journaliers de chaque mai",
                              "moyenne des débits journaliers de chaque juin",
                              "moyenne des débits journaliers de chaque juillet",
                              "moyenne des débits journaliers de chaque août",
                              "moyenne des débits journaliers de chaque septembre",
                              "moyenne des débits journaliers de chaque octobre",
                              "moyenne des débits journaliers de chaque novembre",
                              "moyenne des débits journaliers de chaque décembre"),
                            each=3),
                         " entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = ""
CARD$P.method_fr = ""
CARD$P.sampling_period_fr = rep(c("01-01, 31-01", "01-02, 28(29)-02", "01-03, 31-03",
                                  "01-04, 30-04", "01-05, 31-05", "01-06, 30-06",
                                  "01-07, 31-07", "01-08, 31-08", "01-09, 30-09",
                                  "01-10, 31-10", "01-11, 30-11", "01-12, 31-12"),
                                each=3)
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QMA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

### P2 _______________________________________________________________
CARD$P2.funct = replicate(36, get_deltaX, simplify=FALSE)
names(CARD$P2.funct) = paste0(rep(paste0("deltaQMA_", Months),
                                  each=3), "_", Horizon)

variable = rep(paste0("QMA_", Months), each=3)
HX = rep(Horizon, 12)
CARD$P2.funct_args = replicate(36,
                               list("variable", "date",
                                    past=H0, futur="HX",
                                    to_normalise=CARD$P.to_normalise),
                               simplify=FALSE)
for (i in 1:length(CARD$P2.funct_args)) {
    CARD$P2.funct_args[[i]][1] = variable[i]
    CARD$P2.funct_args[[i]]$futur = get(HX[i])
}

CARD$P2.time_step = "none"
