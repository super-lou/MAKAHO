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
CARD$P.variable_en = c("alphaQJXA", "HYPalphaQJXA")
CARD$P.unit_en = "m^{3}.s^{-1}.year^{-1}"
CARD$P.name_en = "Slope of Sen and Mann-Kendall Test result calculated on the series of annual maximum daily flows QJXA"
CARD$P.description_en = ""
CARD$P.method_en = "1. annual aggregation [Month of minimum monthly flows] - maximum (extraction from the series of QJXA)
2. no temporal aggregation - Sen's slope"
CARD$P.sampling_period_en = "Month of minimum monthly flows"
CARD$P.topic_en = "Flow, High Flows, Intensity"

### French ___________________________________________________________
CARD$P.variable_fr = c("alphaQJXA", "HYPalphaQJXA")
CARD$P.unit_fr = "m^{3}.s^{-1}.an^{-1}"
CARD$P.name_fr = "Pente de Sen et résultat du test de Mann-Kendall calculés sur la série des débits journaliers maximaux annuels QJXA"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation annuelle [Mois du minimum des débits mensuels] - maximum (extraction de la série des QJXA)
2. aucune agrégation temporelle - pente de Sen"
CARD$P.sampling_period_fr = "Mois du minimum des débits mensuels"
CARD$P.topic_fr = "Débit, Hautes Eaux, Intensité"

### Global ___________________________________________________________
CARD$P.source = "KENDALL, M. G. (1975). « Rank Correlation Methods ». Griffin, London, UK.
MANN, H. (1945). « Nonparametric tests against trend ». Econometrica, 13(3):245–259.
SEN, P. K. (1968). « Estimates of the regression coefficient based on Kendall’s tau ». In : Journal of the American Statistical Association 63, p. 1379-1389. DOI : doi:10.2307/2285891."
CARD$P.preferred_hydrological_month = 9
CARD$P.is_date = FALSE
CARD$P.to_normalise = c(TRUE, FALSE)
CARD$P.palette = "#452C1A #7F4A23 #B3762A #D4B86A #EFE0B0 #BCE6DB #7ACEB9 #449C93 #2A6863 #193830"


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(QJXA=maxNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.time_step = "year"
CARD$P1.sampling_period = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(alphaQJXA=get_MKalpha, HYPalphaQJXA=get_MKH)
CARD$P2.funct_args = list(list("QJXA", level=0.1), list("QJXA", level=0.1))
CARD$P2.time_step = "none"

