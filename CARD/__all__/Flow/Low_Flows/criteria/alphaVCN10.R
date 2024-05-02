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
CARD$P.variable_en = c("alphaVCN10", "HYPalphaVCN10")
CARD$P.unit_en = "m^{3}.s^{-1}.year^{-1}"
CARD$P.name_en = "Center of low flows"
CARD$P.description_en = "Date when 50 % of the annual cumulative baseflow is reached"
CARD$P.method_en = "1. annual aggregation [09-01, 08-31] - date when the baseflow sum corresponds to 50 % of the total sum"
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Baseflow, Seasonality"

### French ___________________________________________________________
CARD$P.variable_fr = c("alphaVCN10", "HYPalphaVCN10")
CARD$P.unit_fr = "m^{3}.s^{-1}.an^{-1}"
CARD$P.name_fr = "Pente de Sen et résultat du test de Mann-Kendall calculés sur la série des minimums annuels des débits moyens sur 10 jours VCN10"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. aucune agrégation temporelle - moyenne mobile centrée sur 10 jours
2. agrégation annuelle [Mois du maximum des débits mensuels] - minimum
3. aucune agrégation temporelle - pente de Sen"
CARD$P.sampling_period_fr = "Mois du maximum des débits mensuels"
CARD$P.topic_fr = "Débit, Basses Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.source = "KENDALL, M. G. (1975). « Rank Correlation Methods ». Griffin, London, UK.
MANN, H. (1945). « Nonparametric tests against trend ». Econometrica, 13(3):245–259.
SEN, P. K. (1968). « Estimates of the regression coefficient based on Kendall’s tau ». In : Journal of the American Statistical Association 63, p. 1379-1389. DOI : doi:10.2307/2285891."
CARD$P.is_date = FALSE
CARD$P.to_normalise = c(TRUE, FALSE)
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.time_step = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.time_step = "year"
CARD$P2.sampling_period = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3

### P3 _______________________________________________________________
CARD$P3.funct = list(alphaVCN10=get_MKalpha, HYPalphaVCN10=get_MKH)
CARD$P3.funct_args = list(list("VCN10", level=0.1), list("VCN10", level=0.1))
CARD$P3.time_step = "none"

