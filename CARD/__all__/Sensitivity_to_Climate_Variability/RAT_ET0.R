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
CARD$P.variable_en = "RAT_ET0"
CARD$P.unit_en = "bool"
CARD$P.name_en = "Robustness test to a variation in reference evapotranspiration"
CARD$P.description_en = ""
CARD$P.method_en = "1. annual aggregation [09-01, 08-31] - Qref − Qsim and mean temperatures
2. no temporal aggregation - RAT with a 10 % risk"
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Flow / Evapotranspiration, Sensitivity to Climate Variability"

### French ___________________________________________________________
CARD$P.variable_fr = "RAT_ET0"
CARD$P.unit_fr = "bool"
CARD$P.name_fr = "Test de robustesse à une variation d'évapotranspiration de référence"
CARD$P.description_fr = ""
CARD$P.method_fr = "1. agrégation annuelle [01-09, 31-08] - Qref − Qsim et températures moyennes
2. aucune agrégation temporelle - RAT avec un risque de 10 %"
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Débit / Évapotranspiration, Sensibilité à la variabilité climatique"

### Global ___________________________________________________________
CARD$P.source = "NICOLLE, P. et al. (2021). « Technical note : RAT – a robustness assessment test for calibrated and uncalibrated hydrological models ». In : Hydrol. Earth Syst. Sci. 25, p. 5013-5027. DOI : 10.5194/hess-25-5013-2021."
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(BiasA=compute_Biais, ET0A=mean)
CARD$P1.funct_args = list(list("Q_obs", "Q_sim"), list("ET0_obs", na.rm=TRUE))
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(RAT_ET0=compute_RAT_X)
CARD$P2.funct_args = list("BiasA", "ET0A", thresh=0.05)
CARD$P2.time_step = "none"

