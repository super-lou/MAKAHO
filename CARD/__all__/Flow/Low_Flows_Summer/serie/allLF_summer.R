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
CARD$P.variable_en = c("startLF_summer", "centerLF_summer",
                       "endLF_summer", "dtLF_summer", "vLF_summer")
CARD$P.unit_en = c("yearday", "yearday", "yearday", "day", "hm^{3}")
CARD$P.name_en =
    c("Start of summer low flows",
      "Center of summer low flows",
      "End of summer low flows",
      "Duration of summer low flows",
      "Volume deficit of summer low flows")
CARD$P.description_en =
    c("In summer, date of the first 10-day mean flow value below the threshold set at the maximum of VCN10 (May to November)",
      "In summer, date of the minimal 10-day mean flow value below the threshold set at the maximum of VCN10 (May to November)",
      "In summer, date of the last 10-day mean flow value below the threshold set at the maximum of VCN10 (May to November)",
      "In summer, duration of the longest continuous sequence with 10-day mean flows below the threshold set at the maximum of VCN10 (May to November)",
      "In summer, sum of the differences between the 10-day mean and the maximum of VCN10, over the longest sequence below this threshold (May to November)")
CARD$P.method_en =
    c("1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [05-01, 11-30] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [05-01, 11-30] - date of the first day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average (series of VC10)
2. annual aggregation [05-01, 11-30] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [05-01, 11-30] - date of the minimum of the VC10 of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [05-01, 11-30] - minimum
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [05-01, 11-30] - date of the last day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [05-01, 11-30] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [05-01, 11-30] - number of days in the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [05-01, 11-30] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [05-01, 11-30] - sum of the volumes discharged each day of the longest period below the previous threshold")
CARD$P.sampling_period_en = "05-01, 11-30"
CARD$P.topic_en = c("Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Seasonality",
                    "Flow, Low Flows, Duration",
                    "Flow, Low Flows, Intensity")

### French ___________________________________________________________
CARD$P.variable_fr = c("debutBE_été", "centreBE_été",
                       "finBE_été", "dtBE_été", "vBE_été")
CARD$P.unit_fr = c("jour de l'année", "jour de l'année",
                   "jour de l'année", "jour", "hm^{3}")
CARD$P.name_fr =
    c("Début des basses eaux estivales",
      "Centre des basses eaux estivales",
      "Fin des basses eaux estivales",
      "Durée des basses eaux estivales",
      "Volume de déficit des basses eaux estivales")
CARD$P.description_fr =
    c("En été, date de la première valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de mai à novembre)",
      "En été, date de la valeur minimale des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de mai à novembre)",
      "En été, date de la dernière valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de mai à novembre)",
      "En été, durée de la plus longue séquence continue avec des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10 (mois de mai à novembre)",
      "En été, somme des écarts entre de la moyenne sur 10 jours et le maximum des VCN10, sur la séquence la plus longue sous ce seuil (mois de mai à novembre)")
CARD$P.method_fr =
    c("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-05, 30-11] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-05, 30-11] - date du premier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours (série des VC10)
2. agrégation annuelle [01-05, 30-11] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-05, 30-11] - date du minimum des VC10 de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-05, 30-11] - minimum
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-05, 30-11] - date du dernier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-05, 30-11] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-05, 30-11] - nombre de jours de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [01-05, 30-11] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [01-05, 30-11] - somme des volumes écoulés chaque jour de la plus longue période sous le précédent seuil")
CARD$P.sampling_period_fr = "01-05, 30-11"
CARD$P.topic_fr = c("Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Saisonnalité",
                    "Débit, Basses Eaux, Durée",
                    "Débit, Basses Eaux, Intensité")

### Global ___________________________________________________________
CARD$P.preferred_hydrological_month = 1
CARD$P.is_date = c(TRUE, TRUE, TRUE, FALSE, FALSE)
CARD$P.to_normalise = c(FALSE, FALSE, FALSE, FALSE, TRUE)
CARD$P.palette = c("#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                   "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005",
                   "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005")


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10_summer=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10_summer=minNA)
CARD$P2.funct_args = list("VC10_summer", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = c("05-01", "11-30")
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10_summer", na.rm=TRUE)
CARD$P3.time_step = "none"
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(startLF_summer=apply_threshold,
                     centerLF_summer=apply_threshold,
                     endLF_summer=apply_threshold,
                     dtLF_summer=apply_threshold,
                     vLF_summer=compute_VolDef)
CARD$P4.funct_args = list(list("VC10_summer", lim="upLim",
                               where="<=", what="first",
                               select="longest"),
                          list("VC10_summer", lim="upLim",
                               where="<=", what="which.minNA",
                               select="longest"),
                          list("VC10_summer", lim="upLim",
                               where="<=", what="last",
                               select="longest"),
                          list("VC10_summer", lim="upLim",
                               where="<=", what="length",
                               select="longest"),
                          list("VC10_summer", select="longest",
                               upLim="upLim"))
CARD$P4.time_step = "year"
CARD$P4.sampling_period = c("05-01", "11-30")
CARD$P4.is_date = c(TRUE, TRUE, TRUE, FALSE, FALSE)
CARD$P4.NApct_lim = 3

