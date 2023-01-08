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


#  ___            _     
# | _ ) __ _  ___(_) __ 
# | _ \/ _` |(_-<| |/ _|
# |___/\__,_|/__/|_|\__| _____________________________________________
## 0. BASIC __________________________________________________________
minus = function (a, b, first=FALSE) {
    if (first) {
        a = a[1]
        b = b[1]
    }
    return (a - b)
}

divided = function (a, b, first=FALSE) {
    if (first) {
        a = a[1]
        b = b[1]
    }
    return (a / b)
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
rollmean_center = function (X, k, isCyclical=FALSE) {
    if (isCyclical) {
        n = length(X)
        X = c(X[(n-k+1):n],
              X,
              X[1:(k+1)])
    }    
    X = RcppRoll::roll_mean(X, n=k, fill=NA,
                            align="center",
                            na.rm=FALSE)
    if (isCyclical) {
        n = length(X)
        X = X[(k+1):(n-(k+1))]
    }
    return (X)
}


#' @title Rolling average old
#' @export
rollmean_center_old = function (X, k) {

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
        if (start <= end) {
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


## 4. CIRCULAR STAT __________________________________________________
circularTWEAK = function (X, Y, periodicity) {
    XY2add = abs(X - Y) > (periodicity/2)
    XYmin = pmin(X, Y, na.rm=TRUE)
    XisMin = X == XYmin
    YisMin = Y == XYmin

    XY2add[is.na(XY2add)] = FALSE
    XisMin[is.na(XisMin)] = FALSE
    YisMin[is.na(YisMin)] = FALSE
    
    X[XY2add & XisMin] = X[XY2add & XisMin] + periodicity
    Y[XY2add & YisMin] = Y[XY2add & YisMin] + periodicity

    res = list(X=X, Y=Y)
    return (res)
}

circular_minus = function (X, Y, periodicity) {
    res = circularTWEAK(X, Y, periodicity)
    X = res$X
    Y = res$Y
    return (X - Y)
}
    
circular_divided = function (X, Y, periodicity) {
    res = circularTWEAK(X, Y, periodicity)
    X = res$X
    Y = res$Y
    return (X / Y)
}

circular_median = function (X, periodicity, na.rm=TRUE) {    
    scalingFactor = 2 * pi / periodicity;
    radians = X * scalingFactor
    sines = sin(radians)
    cosines = cos(radians)
    median = atan2(median(sines, na.rm=na.rm), median(cosines, na.rm=na.rm)) / scalingFactor

    print(median)

    if (is.na(median)) {
        res = NA
    } else {
        if (median >= 0) {
            res = median
        } else {
            res = median + periodicity
        }
    }
    return (res)
}
