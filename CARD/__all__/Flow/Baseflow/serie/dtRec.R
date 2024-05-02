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
CARD$P.variable_en = "dtRec"
CARD$P.unit_en = "day"
CARD$P.name_en = "Recession time"
CARD$P.description_en = ""
CARD$P.method_en = ""
CARD$P.topic_en = "Flow, Base Flow, Duration"

### French ___________________________________________________________
CARD$P.variable_fr = "dtRec"
CARD$P.unit_fr = "jour"
CARD$P.name_fr = "Temps de récession"
CARD$P.description_fr = ""
CARD$P.method_fr = ""
CARD$P.topic_fr = "Débit, Débit de Base, Durée"

### Global ___________________________________________________________
CARD$P.is_date = FALSE
CARD$P.to_normalise = TRUE
CARD$P.palette = NULL


## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
CARD$P1.funct = list("dtRec"=compute_dtRec)
CARD$P1.funct_args = list(Q="Q")
CARD$P1.time_step = "none"
CARD$P1.NAyear_lim = 10

