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
CARD$P.variable_en = c("startLF_winter", "centerLF_winter",
                       "endLF_winter", "dtLF_winter", "vLF_winter")
CARD$P.unit_en = c("yearday", "yearday", "yearday", "day", "hm^{3}")
CARD$P.name_en =
    c("Start of winter low flows",
      "Center of winter low flows",
      "End of winter low flows",
      "Duration of winter low flows",
      "Volume deficit of winter low flows")
CARD$P.description_en =
    c("In winter, date of the first 10-day mean flow value below the threshold set at the maximum of VCN10 (November to April)",
      "In winter, date of the minimal 10-day mean flow value below the threshold set at the maximum of VCN10 (November to April)",
      "In winter, date of the last 10-day mean flow value below the threshold set at the maximum of VCN10 (November to April)",
      "In winter, duration of the longest continuous sequence with 10-day mean flows below the threshold set at the maximum of VCN10 (November to April)",
      "In winter, sum of the differences between the 10-day mean and the maximum of VCN10, over the longest sequence below this threshold (November to April)")
CARD$P.method_en =
    c("1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [11-01, 04-30] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [11-01, 04-30] - date of the first day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average (series of VC10)
2. annual aggregation [11-01, 04-30] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [11-01, 04-30] - date of the minimum of the VC10 of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [11-01, 04-30] - minimum
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [11-01, 04-30] - date of the last day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [11-01, 04-30] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [11-01, 04-30] - number of days in the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [11-01, 04-30] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [11-01, 04-30] - sum of the volumes discharged each day of the longest period below the previous threshold")
CARD$P.sampling_period_en = "11-01, 04-30"
CARD$P.topic_en = c("Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Duration",
                    "Flow, Low Flows, Intensity")

### French ___________________________________________________________
CARD$P.variable_fr = c("debutBE_hiver", "centreBE_hiver",
                       "finBE_hiver", "dtBE_hiver",
                       "vBE_hiver")
CARD$P.unit_fr = c("jour de l'année", "jour de l'année",
                   "jour de l'année", "jour", "hm^{3}")
CARD$P.name_fr =
    c("Début des basses eaux hivernales",
      "Centre des basses eaux hivernales",
      "Fin des basses eaux hivernales",
      "Durée des basses eaux hivernales",
      "Volume de déficit des basses eaux hivernales")
CARD$P.description_fr =
    c("En hiver, date de la première valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de novembre à avril)",
      "En hiver, date de la valeur minimale des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de novembre à avril)",
      "En hiver, date de la dernière valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de novembre à avril)",
      "En hiver, durée de la plus longue séquence continue avec des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de novembre à avril)",
      "En hiver, somme des écarts entre de la moyenne sur 10 jours et le maximum des VCN10, sur la séquence la plus longue sous ce seuil (mois de novembre à avril)")
CARD$P.method_fr =
    c("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-11, 30-04] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-11, 30-04] - date du premier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours (série des VC10)
2. agrégation annuelle [01-11, 30-04] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-11, 30-04] - date du minimum des VC10 de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-11, 30-04] - minimum
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-11, 30-04] - date du dernier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-11, 30-04] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-11, 30-04] - nombre de jours de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-11, 30-04] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-11, 30-04] - somme des volumes écoulés chaque jour de la plus longue période sous le précédent seuil")
CARD$P.sampling_period_fr = "01-11, 30-04"
CARD$P.topic_fr = c("Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Durée",
                    "Débit, Basses Eaux, Intensité")

### Global ___________________________________________________________
CARD$P.is_date = c(TRUE, TRUE, TRUE, FALSE, FALSE)
CARD$P.to_normalise = c(FALSE, FALSE, FALSE, FALSE, TRUE)
CARD$P.palette = c("#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005",
                   "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005")


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10_winter=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10_winter=minNA)
CARD$P2.funct_args = list("VC10_winter", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = c("11-01", "04-30")
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10_winter", na.rm=TRUE)
CARD$P3.time_step = "none"
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(startLF_winter=apply_threshold,
                     centerLF_winter=apply_threshold,
                     endLF_winter=apply_threshold,
                     dtLF_winter=apply_threshold,
                     vLF_winter=compute_VolDef)
CARD$P4.funct_args = list(list("VC10_winter", lim="upLim",
                               where="<=", what="first",
                               select="longest"),
                          list("VC10_winter", lim="upLim",
                               where="<=", what="which.minNA",
                               select="longest"),
                          list("VC10_winter", lim="upLim",
                               where="<=", what="last",
                               select="longest"),
                          list("VC10_winter", lim="upLim",
                               where="<=", what="length",
                               select="longest"),
                          list("VC10_winter", select="longest",
                               upLim="upLim"))
CARD$P4.time_step = "year"
CARD$P4.sampling_period = c("11-01", "04-30")
CARD$P4.is_date = c(TRUE, TRUE, TRUE, FALSE, FALSE)
CARD$P4.NApct_lim = 3

