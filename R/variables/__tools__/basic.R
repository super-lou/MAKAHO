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


#  ___            _     
# | _ ) __ _  ___(_) __ 
# | _ \/ _` |(_-<| |/ _|
# |___/\__,_|/__/|_|\__| _____________________________________________
## 0. BASIC __________________________________________________________
minus = function (a, b) {
    return (a - b)
}

## 1. MIN MAX ________________________________________________________                   
minNA = function (X, div=1, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (min(X, na.rm=na.rm) / div)
    }
}

maxNA = function (X, div=1, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (max(X, na.rm=na.rm) / div)
    }
}


## 2. WHICH MIN MAX __________________________________________________
which.minNA = function (X) {
    idMin = which.min(X)
    if (identical(idMin, integer(0))) {
        idMin = NA
    }
    return (idMin)
}

which.maxNA = function (X) {
    idMax = which.max(X)
    if (identical(idMax, integer(0))) {
        idMax = NA
    }
    return (idMax)
}


## 3. ROLLING AVERAGE ________________________________________________
#' @title Rolling average
#' @export
rollmean_center = function (X, k) {

    N = length(X)
    nNAdown = floor((k-1)/2)
    nNAup = ceiling((k-1)/2)
    isNA = is.na(X)

    res = rle(isNA)
    lenNA = res$lengths
    valNA = res$values
    idNAend = cumsum(lenNA)
    idNAstart = idNAend+1
    idNAstart = c(1, idNAstart[1:(length(idNAstart)-1)])
    toNA = (lenNA < k) & !valNA
    isNA[unlist(Map(':', idNAstart[toNA], idNAend[toNA]))] = TRUE

    IdNA = which(isNA)
    res = rle(isNA)
    lenNA = res$lengths
    valNA = res$values
    dNA = length(lenNA)
    dNAstart = lenNA[1] * valNA[1]
    dNAend = lenNA[dNA] * valNA[dNA]
    
    XNoNA = X[!isNA]

    if (length(IdNA) > 1) {
        start = 1 + dNAstart
        end = length(IdNA) - dNAend
        if (start < end) {
            IdNA = IdNA[start:end]
        } else {
            IdNA = NULL
        }
    }

    IdNA = IdNA - nNAdown - dNAstart
    Xroll = accelerometry::movingaves(XNoNA, k)

    if (!identical(IdNA, numeric(0)) & !all(is.na(IdNA))) {

        IdNA = IdNA - 1:length(IdNA)
        Xroll = R.utils::insert(Xroll, IdNA, NA)
    }

    nXroll = length(Xroll)
    IdNA = which(is.na(Xroll))
    for (i in 1:nNAdown) {
        Id = IdNA - i
        Id = Id[Id > 0]
        Xroll[Id] = NA
    }
    for (i in 1:nNAup) {
        Id = IdNA + i
        Id = Id[Id < nXroll]
        Xroll[Id] = NA
    }
    
    Xroll = c(rep(NA, dNAstart), Xroll)
    Xroll = c(Xroll, rep(NA, dNAend))
    Xroll = c(rep(NA, nNAdown), Xroll)
    Xroll = c(Xroll, rep(NA, nNAup))
    return (Xroll)
}
