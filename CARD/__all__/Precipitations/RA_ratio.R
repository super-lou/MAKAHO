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
CARD$P.variable_en = "RA_ratio"
CARD$P.unit_en = "without unit"
CARD$P.name_en = "Precipitation ratio"
CARD$P.description_en = ""
CARD$P.method_en = ""
CARD$P.sampling_period_en = "09-01, 08-31"
CARD$P.topic_en = "Precipitations, Moderate, Ratio"

### French ___________________________________________________________
CARD$P.variable_fr = "RA_ratio"
CARD$P.unit_fr = "sans unité"
CARD$P.name_fr = "Ratio des précipitation"
CARD$P.description_fr = ""
CARD$P.method_fr = ""
CARD$P.sampling_period_fr = "01-09, 31-08"
CARD$P.topic_fr = "Précipitations, Modérée, Ratio"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = FALSE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(RA=sumNA, RAl=sumNA, RAs=sumNA)
CARD$P1.funct_args = list(list("R", na.rm=TRUE), list("Rl", na.rm=TRUE), list("Rs", na.rm=TRUE))
CARD$P1.time_step = "year"
CARD$P1.sampling_period = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

### P2 _______________________________________________________________
CARD$P2.funct = list(meanRA=mean, meanRAl=mean, meanRAs=mean)
CARD$P2.funct_args = list(list("RA", na.rm=TRUE), list("RAl", na.rm=TRUE), list("RAs", na.rm=TRUE))
CARD$P2.time_step = "none"

### P3 _______________________________________________________________
CARD$P3.funct = list(Rl_ratio=divided, Rs_ratio=divided)
CARD$P3.funct_args = list(list("meanRAl", "meanRA"), list("meanRAs", "meanRA"))
CARD$P3.time_step = "none"

