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


#  _____  _                   _          _     _ 
# |_   _|| |_   _ _  ___  ___| |_   ___ | | __| |
#   | |  | ' \ | '_|/ -_)(_-<| ' \ / _ \| |/ _` |
#   |_|  |_||_||_|  \___|/__/|_||_|\___/|_|\__,_| ____________________
## 1. UNDER __________________________________________________________  
under_threshold = function (X, UpLim, what="X", select_longest=TRUE) {
    
    ID = which(X <= UpLim)

    if (select_longest) {
        dID = diff(ID)
        dID = c(10, dID)
        
        IDjump = which(dID != 1)
        Njump = length(IDjump)
        
        Periods = vector(mode='list', length=Njump)
        Nperiod = c()
        
        for (i in 1:Njump) {
            idStart = IDjump[i]
            
            if (i < Njump) {
                idEnd = IDjump[i+1] - 1
            } else {
                idEnd = length(ID)
            }
            
            period = ID[idStart:idEnd]
            Periods[[i]] = period
            Nperiod = c(Nperiod, length(period))
        }
        period_max = Periods[[which.max(Nperiod)]]

        if (what == "X") {
            res = X[period_max]
        } else if (what == "length") {
            res = period_max[length(period_max)] - period_max[1] + 1
        } else if (what == "last") {
            res = period_max[length(period_max)]
        } else if (what == "first") {
            res = period_max[1]
        }
        
    } else {
        if (what == "X") {
            res = X[ID]            
        } else if (what == "length") {
            res = ID[length(ID)] - ID[1] + 1
        } else if (what == "last") {
            res = ID[length(ID)]
        } else if (what == "first") {
            res = ID[1]
        }
    }
    return (res)
}


## 2. USE ____________________________________________________________
compute_VolDef = function (X, UpLim, select_longest=TRUE) {
    Xdef = under_threshold(X, UpLim=UpLim, what="X",
                           select_longest=select_longest)
    Vol = sum(Xdef)*24*3600 / 10^6 # m^3.s-1 * jour / 10^6 -> hm^3
    return (Vol)
}
