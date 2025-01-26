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
CARD$P.variable_en = c("startLF", "centerLF", "endLF", "dtLF", "vLF")
CARD$P.unit_en = c("yearday", "yearday", "yearday", "day", "hm^{3}")
CARD$P.name_en = c("Start of low flows",
                   "Center of low flows",
                   "End of low flows",
                   "Duration of low flows",
                   "Volume deficit of low flows")
CARD$P.description_en = c("Date of the first 10-day mean flow value below the threshold set at the maximum of VCN10",
                          "Date of the minimal 10-day mean flow value below the threshold set at the maximum of VCN10",
                          "Date of the last 10-day mean flow value below the threshold set at the maximum of VCN10",
                          "Duration of the longest continuous sequence with 10-day mean flows below the threshold set at the maximum of VCN10",
                          "Sum of differences between the 10-day mean and the maximum of VCN10, over the longest sequence below this threshold")
CARD$P.method_en = c("1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - date of the first day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average (series of VC10)
2. annual aggregation [Month of maximum monthly flows] - minimum (series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - date of the minimum of the VC10 of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - date of the last day of the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - number of days in the longest period below the previous threshold",
"1. no temporal aggregation - 10-day centered moving average
2. annual aggregation [Month of maximum monthly flows] - minimum (extraction from the series of VCN10)
3. no temporal aggregation - the maximum of the previous series is taken as the threshold
4. annual aggregation [Month of maximum monthly flows] - sum of volumes discharged each day in the longest period below the previous threshold")
CARD$P.sampling_period_en = "Month of maximum monthly flows"
CARD$P.topic_en = ""

### French ___________________________________________________________
CARD$P.variable_fr = c("debutBE", "centreBE", "finBE", "dtBE", "vBE")
CARD$P.unit_fr = c("jour de l'année", "jour de l'année",
                   "jour de l'année", "jour", "hm^{3}")
CARD$P.name_fr = c("Début des basses eaux",
                   "Centre des basses eaux",
                   "Fin des basses eaux",
                   "Durée des basses eaux",
                   "Volume de déficit des basses eaux")
CARD$P.description_fr = c("Date de la première valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Date de la valeur minimale des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Date de la dernière valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Durée de la plus longue séquence continue avec des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Somme des écarts entre de la moyenne sur 10 jours et le maximum des VCN10, sur la séquence la plus longue sous ce seuil")
CARD$P.method_fr = c("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - date du premier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours (série des VC10)
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (série des VCN10)
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - date du minimum des VC10 de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - date du dernier jour de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - nombre de jours de la plus longue période sous le précédent seuil",
"1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum (extraction de la série des VCN10
3. aucune agrégation temporelle - le maximum de la précédente série est pris comme seuil
4. agrégation annuelle [Mois du maximum des débits mensuels] - somme des volumes écoulés chaque jour de la plus longue période sous le précédent seuil")
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
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
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

### P3 _______________________________________________________________
CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10", na.rm=TRUE)
CARD$P3.time_step = "none"
CARD$P3.keep = "all"

### P4 _______________________________________________________________
CARD$P4.funct = list(startLF=apply_threshold,
                     centerLF=apply_threshold,
                     endLF=apply_threshold,
                     dtLF=apply_threshold,
                     vLF=compute_VolDef)
CARD$P4.funct_args = list(list("VC10", lim="upLim", where="<=",
                               what="first", select="longest"),
                          list("VC10", lim="upLim", where="<=",
                               what="which.minNA", select="longest"),
                          list("VC10", lim="upLim", where="<=",
                               what="last", select="longest"),
                          list("VC10", lim="upLim", where="<=",
                               what="length", select="longest"),
                          list("VC10", select="longest",
                               upLim="upLim"))
CARD$P4.time_step = "year"
CARD$P4.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P4.is_date = c(TRUE, TRUE, TRUE, FALSE, FALSE)
CARD$P4.NApct_lim = 3
