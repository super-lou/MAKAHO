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
CARD$P.variable_en = c("alphaQA", "HYPalphaQA")
CARD$P.unit_en = "m^{3}.s^{-1}.year^{-1}"
CARD$P.name_en = "Slope of Sen and Mann-Kendall Test result calculated on the series of annual mean daily flows"
CARD$P.description_en = "1. annual aggregation [09-01, 08-31] - mean
2. no temporal aggregation - Sen's slope of the series where the Mann-Kendall test is significant at a 10 % risk level"
CARD$P.method_en = ""
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow, Mean Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = c("alphaQA", "HYPalphaQA")
CARD$P.unit_fr = "m^{3}.s^{-1}.an^{-1}"
CARD$P.name_fr = "Pente de Sen et résultat du test de Mann-Kendall calculés sur la série des moyennes annuelles des débits journaliers"
CARD$P.description_fr = "1. agrégation annuelle [01-09, 31-08] - moyenne
2. aucune agrégation temporelle - pente de Sen de la série dont le test de Mann-Kendall est significatif à un risque de 10 %"
CARD$P.method_fr = ""
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit, Moyennes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.source = "KENDALL, M. G. (1975). « Rank Correlation Methods ». Griffin, London, UK.
MANN, H. (1945). « Nonparametric tests against trend ». Econometrica, 13(3):245–259.
SEN, P. K. (1968). « Estimates of the regression coefficient based on Kendall’s tau ». In : Journal of the American Statistical Association 63, p. 1379-1389. DOI : doi:10.2307/2285891."
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = c(TRUE, FALSE)
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(alphaQA=get_MKalpha, HYPalphaQA=get_MKH)
CARD$P2.funct_args = list(list("QA", level=0.1), list("QA", level=0.1))
CARD$P2.time_step = "none"

