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
                            rep(c("{startLF}", "{centerLF}", "{endLF}", "{dtLF}", "{vLF}"),
                                each=3), "_", Horizon)
CARD$P.unit_en = rep(c("day", "day", "day", "day", "%"),
                     each=3)
CARD$P.name_en = paste0("Average change of ",
                        rep(c("the start of low flows",
                              "the center of low flows",
                              "the End of low flows",
                              "duration of low flows",
                              "low flow deficit volume"),
                            each=3),
                        " between the ", Horizon_en, " horizon and historical period")
CARD$P.description_en = rep(c("Date of the first 10-day mean flow value below the threshold set at the maximum of VCN10",
                              "Date of the minimal 10-day mean flow value below the threshold set at the maximum of VCN10",
                              "Date of the last 10-day mean flow value below the threshold set at the maximum of VCN10",
                              "Duration of the longest continuous sequence with 10-day mean flows below the threshold set at the maximum of VCN10",
                              "Sum of differences between the 10-day mean and the maximum of VCN10, over the longest sequence below this threshold"),
                            each=3)
CARD$P.method_en = paste0(rep(c("1. no temporal aggregation - 10-day centered moving average
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
4. annual aggregation [Month of maximum monthly flows] - sum of volumes discharged each day in the longest period below the previous threshold"),
each=3),
"\n2. no temporal aggregation - calculation of the average change between the historical period and the ", Horizon_en, " horizon")
CARD$P.sampling_period_en = "Month of maximum monthly flows"
CARD$P.topic_en = rep(c("Flow, Low Flows, Seasonality",
                        "Flow, Low Flows, Seasonality",
                        "Flow, Low Flows, Seasonality",
                        "Flow, Low Flows, Duration",
                        "Flow, Low Flows, Intensity"), each=3)

### French ___________________________________________________________
CARD$P.variable_fr = paste0("delta",
                            rep(c("{debutBE}", "{centreBE}", "{finBE}", "{dtBE}", "{vBE}"),
                                each=3), "_", Horizon)
CARD$P.unit_fr = rep(c("jour", "jour",
                       "jour", "jour", "%"), each=3)
CARD$P.name_fr = paste0("Changement moyen ",
                        rep(c("du début des basses eaux",
                              "du centre des basses eaux",
                              "de la fin des basses eaux",
                              "de la durée des basses eaux",
                              "du volume de déficit des basses eaux"),
                            each=3),
                        " entre l'horizon ", Horizon_fr, " et la période historique")
CARD$P.description_fr = rep(c("Date de la première valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Date de la valeur minimale des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Date de la dernière valeur de débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Durée de la plus longue séquence continue avec des débits moyens sur 10 jours sous le seuil fixé au maximum des VCN10",
                          "Somme des écarts entre de la moyenne sur 10 jours et le maximum des VCN10, sur la séquence la plus longue sous ce seuil"),
                          each=3)
CARD$P.method_fr = paste0(rep(c("1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
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
4. agrégation annuelle [Mois du maximum des débits mensuels] - somme des volumes écoulés chaque jour de la plus longue période sous le précédent seuil"),
each=3),
"\n2. aucune agrégation temporelle - calcul du changement moyen entre la période historique et l'horizon ", Horizon_fr)
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
CARD$P.topic_fr = rep(c("Débit, Basses Eaux, Saisonnalité",
                        "Débit, Basses Eaux, Saisonnalité",
                        "Débit, Basses Eaux, Saisonnalité",
                        "Débit, Basses Eaux, Durée",
                        "Débit, Basses Eaux, Intensité"), each=3)

### Global ___________________________________________________________
CARD$P.is_date = rep(c(TRUE, TRUE, TRUE, FALSE, FALSE), each=3)
CARD$P.to_normalise = rep(c(FALSE, FALSE, FALSE, FALSE, TRUE), each=3)
CARD$P.palette = rep(c("#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                       "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                       "#60265e #893687 #c05fbe #dba3da #edd1ec #f6ddd3 #edbaa7 #e08765 #CD5629 #8f3c1d",
                       "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005",
                       "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005"),
                     each=3)


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

### P5 _______________________________________________________________
CARD$P5.funct = list("delta{startLF}_H1"=get_deltaX,
                     "delta{startLF}_H2"=get_deltaX,
                     "delta{startLF}_H3"=get_deltaX,

                     "delta{centerLF}_H1"=get_deltaX,
                     "delta{centerLF}_H2"=get_deltaX,
                     "delta{centerLF}_H3"=get_deltaX,
                     
                     "delta{endLF}_H1"=get_deltaX,
                     "delta{endLF}_H2"=get_deltaX,
                     "delta{endLF}_H3"=get_deltaX,

                     "delta{dtLF}_H1"=get_deltaX,
                     "delta{dtLF}_H2"=get_deltaX,
                     "delta{dtLF}_H3"=get_deltaX,

                     "delta{vLF}_H1"=get_deltaX,
                     "delta{vLF}_H2"=get_deltaX,
                     "delta{vLF}_H3"=get_deltaX)

CARD$P5.funct_args = list(list("startLF", "date",
                               past=H0, futur=H1,
                               to_normalise=FALSE),
                          list("startLF", "date",
                               past=H0, futur=H2,
                               to_normalise=FALSE),
                          list("startLF", "date",
                               past=H0, futur=H3,
                               to_normalise=FALSE),

                          list("centerLF", "date",
                               past=H0, futur=H1,
                               to_normalise=FALSE),
                          list("centerLF", "date",
                               past=H0, futur=H2,
                               to_normalise=FALSE),
                          list("centerLF", "date",
                               past=H0, futur=H3,
                               to_normalise=FALSE),

                          list("endLF", "date",
                               past=H0, futur=H1,
                               to_normalise=FALSE),
                          list("endLF", "date",
                               past=H0, futur=H2,
                               to_normalise=FALSE),
                          list("endLF", "date",
                               past=H0, futur=H3,
                               to_normalise=FALSE),

                          list("dtLF", "date",
                               past=H0, futur=H1,
                               to_normalise=FALSE),
                          list("dtLF", "date",
                               past=H0, futur=H2,
                               to_normalise=FALSE),
                          list("dtLF", "date",
                               past=H0, futur=H3,
                               to_normalise=FALSE),

                          list("vLF", "date",
                               past=H0, futur=H1,
                               to_normalise=FALSE),
                          list("vLF", "date",
                               past=H0, futur=H2,
                               to_normalise=FALSE),
                          list("vLF", "date",
                               past=H0, futur=H3,
                               to_normalise=FALSE))
CARD$P5.time_step = "none"
