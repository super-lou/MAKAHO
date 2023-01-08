# Copyright 2022-2023 Louis Héraut (louis.heraut@inrae.fr)*1
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


#  _____                     _ 
# |_   _| _ _  ___  _ _   __| |
#   | |  | '_|/ -_)| ' \ / _` |
#   |_|  |_|  \___||_||_|\__,_| ______________________________________
## 1. MANN-KENDALL TREND TEST ________________________________________
## 1.1. Alpha ________________________________________________________
get_MKalpha = function (X, level=0.1) {
    alpha = GeneralMannKendall_WRAP(X, level=level,
                                    timeDep_option='AR1',
                                    DoDetrending=TRUE)$a
    return (alpha)
}

## 1.2. Test result __________________________________________________
get_MKH = function (X, level=0.1) {
    H = GeneralMannKendall_WRAP(X, level=level,
                                timeDep_option='AR1',
                                DoDetrending=TRUE)$H
    return (H)    
}
