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
CARD$P.variable_en = "Rc"
CARD$P.unit_en = "m^{3}.s^{-1}.mm^{-1}"
CARD$P.name_en = "Runoff coefficient"
CARD$P.description_en = "The ratio between the sum of flows and the sum of precipitations"
CARD$P.method_en = ""
CARD$P.topic_en = "Flow / Precipitations, Sensitivity to climate variability"

### French ___________________________________________________________
CARD$P.variable_fr = "Rc"
CARD$P.unit_fr = "m^{3}.s^{-1}.mm^{-1}"
CARD$P.name_fr = "Coefficient de ruissellement"
CARD$P.description_fr = "Rapport entre la somme des débits et la somme des précipitations"
CARD$P.method_fr = ""
CARD$P.topic_fr = "Débit / Précipitations, Sensibilité à la variabilité climatique"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list(Rc=compute_Rc)
CARD$P1.funct_args = list("Q", "P")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

