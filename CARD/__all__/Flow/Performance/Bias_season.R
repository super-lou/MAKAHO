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
CARD$P.variable_en = c("Bias_DJF", "Bias_MAM",
                       "Bias_JJA", "Bias_SON")
CARD$P.unit_en = "without unit"
CARD$P.name_en = c("Winter Bias", "Autumn Bias",
                   "Summer Bias", "Winter Bias")
CARD$P.description_en =
    c("Relative difference between simulated and reference winter data. Similar to Bias, this score measures the mean deviation only over winter months (December, January, and February).",
      "Relative difference between simulated and reference spring data. Similar to Bias, this score measures the mean deviation only over spring months (March, April, and May).",
      "Relative difference between simulated and reference summer data. Similar to Bias, this score measures the mean deviation only over summer months (June, July, and August).",
      "Relative difference between simulated and reference autumn data. Similar to Bias, this score measures the mean deviation only over autumn months (September, October, and November).")
CARD$P.method_en = c("1. seasonal aggregation [01-12, 28(29)-02] - Bias calculation",
                     "1. seasonal aggregation [01-03, 31-05] - Bias calculation",
                     "1. seasonal aggregation [01-06, 31-08] - Bias calculation",
                     "1. seasonal aggregation [01-09, 30-11] - Bias calculation")
CARD$P.sampling_period_en = c("12-01, 02-28(29)",
                              "03-01, 05-31",
                              "06-01, 08-31",
                              "09-01, 11-30")
CARD$P.topic_en = "Flow, Performance"


### French ___________________________________________________________
CARD$P.variable_fr = c("Biais_DJF", "Biais_MAM",
                       "Biais_JJA", "Biais_SON")
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = c("Biais hivernal", "Biais automnal",
                   "Biais estival", "Biais hivernal")
CARD$P.description_fr =
    c("Différence relative entre les données d’hiver simulées et de référence. Identique au Biais, ce score mesure l’écart moyen uniquement sur les mois d’hiver (mois de décembre, janvier et février).",
      "Différence relative entre les données de printemps simulées et de référence. Identique au Biais, ce score mesure l’écart moyen uniquement sur les mois de printemps (mois de mars, avril et mai).",
      "Différence relative entre les données d’été simulées et de référence. Identique au Biais, ce score mesure l’écart moyen uniquement sur les mois d’été (mois de juin, juillet et août).",
      "Différence relative entre les données d’automne simulées et de référence. Identique au Biais, ce score mesure l’écart moyen uniquement sur les mois d’automne (mois de septembre, octobre et novembre).")
CARD$P.method_fr = c("1. agrégation saisonnière [01-12, 28(29)-02] - calcul du Biais",
                     "1. agrégation saisonnière [01-03, 31-05] - calcul du Biais",
                     "1. agrégation saisonnière [01-06, 31-08] - calcul du Biais",
                     "1. agrégation saisonnière [01-09, 30-11] - calcul du Biais")
CARD$P.sampling_period_fr = c("01-12, 28(29)-02",
                              "01-03, 31-05",
                              "01-06, 31-08",
                              "01-09, 30-11")
CARD$P.topic_fr = "Débit, Performance"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(Bias=compute_Biais)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.time_step = "season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.compress = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

