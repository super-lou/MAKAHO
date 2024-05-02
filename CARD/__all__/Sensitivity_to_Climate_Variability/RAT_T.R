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
CARD$P.variable_en = "RAT_T"
CARD$P.unit_en = "bool"
CARD$P.name_en = "Robustness test to air temperature variation"
CARD$P.description_en = ""
CARD$P.method_en = "1. annual aggregation [09-01, 08-31] - Qref − Qsim and mean temperatures
2. no temporal aggregation - RAT with a 10 % risk"
CARD$P.topic_en = "Flow / Temperature, Sensitivity to Climate Variability"
CARD$P.sampling_period_en = "09-01, 08-31"

### French ___________________________________________________________
CARD$P.variable_fr = "RAT_T"
CARD$P.unit_fr = "bool"
CARD$P.name_fr = "Test de robustesse à une variation de température de l’air"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation annuelle [01-09, 31-08] - Qref − Qsim et températures moyennes
2. aucune agrégation temporelle - RAT avec un risque de 10 %"
CARD$P.topic_fr = "Débit / Température, Sensibilité à la variabilité climatique"
CARD$P.sampling_period_fr = "01-09, 31-08"

### Global ___________________________________________________________
CARD$P.source = "NICOLLE, P. et al. (2021). « Technical note : RAT – a robustness assessment test for calibrated and uncalibrated hydrological models ». In : Hydrol. Earth Syst. Sci. 25, p. 5013-5027. DOI : 10.5194/hess-25-5013-2021."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(BiasA=compute_Biais, TA=mean)
CARD$P1.funct_args = list(list("Q_obs", "Q_sim"), list("T_obs", na.rm=TRUE))
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(RAT_T=compute_RAT_X)
CARD$P2.funct_args = list("BiasA", "TA", thresh=0.05)
CARD$P2.time_step = "none"

