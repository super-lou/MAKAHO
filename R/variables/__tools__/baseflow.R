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


#  ___                  __  _              
# | _ ) __ _  ___ ___  / _|| | ___ __ __ __
# | _ \/ _` |(_-</ -_)|  _|| |/ _ \\ V  V /
# |___/\__,_|/__/\___||_|  |_|\___/ \_/\_/ ___________________________
## 1. BASEFLOW SEPARATION ____________________________________________
BFS = function (Q, d=5, w=0.9) {

    N = length(Q)
    if (all(is.na(Q))) {
        return (NA)
    }
    Slices = split(Q, ceiling(seq_along(Q)/d))    
    idMinSlices = unlist(lapply(Slices, which.minNA),
                         use.names=FALSE)
    
    idShift = c(0, cumsum(unlist(lapply(Slices, length),
                                 use.names=FALSE)))
    idShift = idShift[-length(idShift)]
    idMin = idMinSlices + idShift
    Qmin_k = Q[idMin]

    if (length(Qmin_k) == 1) {
        BF = rep(NA, N)
        return (BF)
    }

    n = length(Qmin_k)
    Qmin_kp1 = c(Qmin_k[2:n], NA)
    Qmin_km1 = c(NA, Qmin_k[1:(n-1)])
    test = w * Qmin_k < pmin(Qmin_km1, Qmin_kp1)
    test[is.na(test)] = FALSE
    idPivots = idMin[which(test)]
    Pivots = Qmin_k[test]

    nbNAid = length(idPivots[!is.na(idPivots)])
    nbNA = length(Pivots[!is.na(Pivots)])
    if (nbNAid >= 2 & nbNA >= 2) {
        BF = Hmisc::approxExtrap(idPivots, Pivots, xout=1:N,
                          method="linear", na.rm=TRUE)$y  
        BF[is.na(Q)] = NA
        BF[BF < 0] = 0
        test = BF > Q
        test[is.na(test)] = FALSE
        BF[test] = Q[test]
        
    } else {
        BF = rep(NA, N)
    }    
    return (BF)
}


## 2. BASEFLOW INDEX _________________________________________________
#' @title baseflow_index
#' @description Compute the baseflow index: the ratio between the
#' total baseflow volume and the total streamflow volume.
#' Warning : No checks are done on inputs ! You should have selected
#' the proper period before hand (i.e. both vector should be of same
#' length and span over the same period).
#' @param Q Streamflow vector
#' @param Qbf Baseflow vector
#' @param na.rm Should missing values be omited ?
#' @return
#' @export
baseflow_index = function (Q, Qbf, na.rm = TRUE) {
    if (length(Q) != length(Qbf)) warning("'Q' and 'Qbf' don't have the same length!")
    res = sum(Qbf, na.rm=na.rm) / sum(Q, na.rm=na.rm)
    return (res)
} 


## 3. BASEFLOW MAGNITUDE _____________________________________________
# TODO : check dims of inputs !
# FIXME : do not call roll_mean when n == 1
#' @title baseflow_regime_magnitude
#' @description Computes the baseflow magnitude: it is the relative
#' difference between the maxima and minima of the 'n'-days smoothed
#' inter-annual daily average of baseflow time series. Note in this
#' second version, the min and the max are also returned and the
#' default smoothing is 1 (i.e. no smoothing)
#' @param Qbf Baseflow vector
#' @param days Vector containting the days of the (hydrological) year 
#' @param n Window size for the rolling mean function
#' @return
#' @export
baseflow_regime_magnitude = function (Qbf, hdays, n = 1) {
    x = data.frame(Qbf, hdays)
    y = x %>% group_by(hdays) %>% aggregate(. , by = list(hdays), FUN = mean, na.rm = TRUE)
    y = roll_mean(y[["Qbf"]], n = n, fill = NA, align = "center")
    max_y = max(y, na.rm = TRUE)
    min_y = min(y, na.rm = TRUE)
    c(mag = (max_y - min_y) / max_y, min = min_y, max = max_y)
}


## 4. USE ____________________________________________________________
### 4.1. Volumic _____________________________________________________
compute_VolSnowmelt = function (X) {
    BF = BFS(X)
    VolSnowmelt = sum(BF, na.rm=TRUE)*24*3600 / 10^6 # m^3.s-1 * jour / 10^6 -> hm^3
    return (VolSnowmelt)
}

### 4.2. Temporal_____________________________________________________
compute_tVolSnowmelt = function (X, p) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt / maxNA(VolSnowmelt, na.rm=TRUE)
    idp = which.minNA(abs(pVolSnowmelt - p))
    return (idp)
}

### 4.3. Duration ____________________________________________________
compute_tSnowmelt = function (X, p1, p2) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt / maxNA(VolSnowmelt, na.rm=TRUE)
    idp1 = which.minNA(abs(pVolSnowmelt - p1))
    idp2 = which.minNA(abs(pVolSnowmelt - p2))
    len = idp2 - idp1 + 1
    return (len)
}
