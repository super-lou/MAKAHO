# \\\
# Copyright 2021-2022 Louis Héraut*1
#
# *1   INRAE, France
#      louis.heraut@inrae.fr
#
# This file is part of Ashes R toolbox.
#
# Ashes R toolbox is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Ashes R toolbox is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ash R toolbox.
# If not, see <https://www.gnu.org/licenses/>.
# ///


#  _____                     _ 
# |_   _| _ _  ___  _ _   __| |
#   | |  | '_|/ -_)| ' \ / _` |
#   |_|  |_|  \___||_||_|\__,_| ______________________________________
## 1. MANN-KENDALL TREND TEST ________________________________________
## 1.1. Alpha ________________________________________________________
get_MKalpha = function (X, level=0.1) {
    alpha = MKstat::GeneralMannKendall_WRAP(X, level=level,
                                            timeDep_option='AR1',
                                            DoDetrending=TRUE)$a
    return (alpha)
}

## 1.2. Test result __________________________________________________
get_MKH = function (X, level=0.1) {
    H = MKstat::GeneralMannKendall_WRAP(X, level=level,
                                        timeDep_option='AR1',
                                        DoDetrending=TRUE)$H
    return (H)    
}
