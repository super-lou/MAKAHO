# Copyright 2020 Ivan Horner (ivan.horner@irstea.fr)*1,
#           2022-2023 Louis Héraut (louis.heraut@inrae.fr)*2
#
# *1   IRSTEA, France
# *2   INRAE, France
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


#  ___                                  _ 
# / __| ___  __ _  ___ ___  _ _   __ _ | |
# \__ \/ -_)/ _` |(_-</ _ \| ' \ / _` || |
# |___/\___|\__,_|/__/\___/|_||_|\__,_||_|
#     _                           _     
#  __| | _  _  _ _   __ _  _ __  (_) __ 
# / _` || || || ' \ / _` || '  \ | |/ _|
# \__,_| \_, ||_||_|\__,_||_|_|_||_|\__| _____________________________
#        |__/  
## 1. RUNOFF COEFFICIENT _____________________________________________
#' @title runoff_coefficient
#' @description Computes the runoff coefficient or ratio: the ratio
#' between the total strealfow volume and the total precipitaion
#' volume. Warning: No checks are done on inputs ! You should have
#' selected the proper period beforehand: both vector should be of
#' same length and span over the same period. In addition the runoff
#' coefficient should be compute from the start of a hydrological
#' year to the end of a hydrological year.
#' @param Q Streamflow vector
#' @param R Precipitation vector
#' @param na.rm Should missing values be omited ?
#' @return Runoff coefficient
#' @export
compute_Rc = function(Q, R, na.rm=TRUE) {
    if (length(Q) != length(R)) {
        warning("'Q' and 'R' don't have the same length!")
    }
    res = sum(Q, na.rm=na.rm) / sum(R, na.rm=na.rm)
    return (res)
}


## 2 PQ SLOPE ________________________________________________________
# TODO : implement an option to verify the 'validity' of the
# interpolation. For example, it should not be longer than 'n' time
# step or I could provide a value indicating how much the interpolated
# value weight on the resulting cumulative curve
#' @title hsaCumsum
#' @description Wrapper around cumsum() to linearly interpolate
#' missing values
#' @param x vector to use to compute cumulated values
#' @param na.action action to undertake when missing values are found
#' (default: 'interpolate', any other value leads to the original
#' cumsum() function)
#' @return
#' @export
hsaCumsum = function(x, na.action = "interpolate") {
    isna = is.na(x)
    if (all(isna)) stop("'x' cannot be only missing values!")
    if (any(isna)) {
        if (na.action == "interpolate") {
            y = 1:length(x)
            x[isna] = approx(x = y[!isna], y = x[!isna], xout = y[isna], method = "linear")$y
        } else if (is.numeric(na.action)) {
            x[isna] = na.action
        }
        isna = is.na(x)
        if (any(isna)) {
            warning("'x' has missing values at the start/end! They were treated as zeros.")
            x[isna] = 0
            y = cumsum(x)
            y[isna] = NA
            return(y)
        }
    }
    cumsum(x)
}

# TODO : check dims of inputs !
#' @title pq_slopes
#' @description Computes the cumulative inter-annual daily average of
#' R and Q as well as the difference R-Q. Then, compute the seasonal
#' response change signatures following the so-called R-Q approach :
#' breackpoint date, first period slope (dry), second period slope
#' (wet) and the intercepts associated with these two slopes (only
#' there for plotting purposes).
#' @param Q Streamflow vector
#' @param R precipitation vector
#' @param hdays Days of the (Hydrological) years vector
#' @param start start of period to search for change of trend in R-Q
#' @param end end of period to search for change of trend in R-Q
#' @param bp initial guess of threshold date
#' @param intercept should the intercept be estimated (default: TRUE)
#' or fixed to c(0, 0) (FALSE) ?
#' @return
#' @export
rq_slopes = function(Q, R, hdays, start=15, end=183, bp=mean(c(start, end)), intercept=TRUE) {
    RQ = data.frame(Q, R, hdays) %>% 
        group_by(hdays) %>%
        summarise_all(mean, na.rm = TRUE) %>%
        mutate_at(vars(Q, R), hsaCumsum) %>%
        mutate(R_Q = R - Q)
    RQ = RQ$R_Q
    x = start:end
    y = RQ[x]
    if (intercept) {
        reg = segmented(lm(y ~ x), psi = bp)
        coefs = reg$coefficients
    } else {
        reg = segmented(lm(y ~ x + 0), psi = bp)
        coefs = c(0, reg$coefficients)
    }
    coefs[3L] = sum(coefs[2:3])
    bp = reg$psi[, 2L]
    
    out = c(bp, 1 - coefs[3L] / coefs[2L], coefs[2L], coefs[1L], coefs[3L], coefs[2L] * bp + coefs[1L] - coefs[3L] * bp)
    names(out) = c("bp", "bp_strength", "slp_dry", "b_dry", "slp_wet", "b_wet")
    out
}
