# Copyright 2022 David Dorchies*1,
#           2022-2023 Louis Héraut (louis.heraut@inrae.fr)*2
#
# *1   UMR G-EAU, France
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


#  ___       _                                        _          _ 
# | _ \ ___ | |_  _  _  _ _  _ _      _ __  ___  _ _ (_) ___  __| |
# |   // -_)|  _|| || || '_|| ' \    | '_ \/ -_)| '_|| |/ _ \/ _` |
# |_|_\\___| \__| \_,_||_|  |_||_| _ | .__/\___||_|  |_|\___/\__,_| __
## 1. GUMBEL LAW ___________________ |_| _____________________________
#' @title compute_GumbelParams
#' @description Computes Gumbel's laws parameters
#' @param X Maximum flow at a given time step (usually the maximum
#' daily flow per year)
#' @return A [list] with `a` the location parameter and `b` the scale
#' parameter
#' @examples
#'# load data
#'data(L0123001, package="airGR")
#'# define vector of flows, time step is the day
#'flows = BasinObs$Qls
#'# define vector of dates
#'dates= BasinObs$DatesR
#' QJXA = calcQJXA(x=dates, flows=flows)
#' gumbel = getGumbelParams(QJXA)
#' @export
compute_GumbelParams = function (X) {
    if (!is.numeric(X)) {
        stop("maxFlows must be of class 'numeric'")
    }
    # Euler constant
    c_euler = 0.5772
    # Scale parameter
    b = sqrt(6) / pi * sd(X, na.rm=TRUE)
    # Location parameter
    a = mean(X, na.rm=TRUE) - b*c_euler    
    GumbelParams = list(a=a, b=b)
    return (GumbelParams)
}

#' @title compute_GumbelLaw
#' @description Computes Gumbel law
#' @param a The location parameter of Gumbel law
#' @param b The scale parameter of Gumbel law
#' @param returnPeriod [numeric] Return period. Its unit is given by
#' the aggregation time step used for the Gumbel law.
#' @return Gumbel law value
#' @export
compute_GumbelLaw = function (a, b, returnPeriod) {
    if (!is.numeric(returnPeriod)) {
        stop("returnPeriod must be of class 'numeric'")
    }
    if (returnPeriod <= 1) {
        stop("returnPeriod must be greater than 1")
    }
    # Non-exceeding frequency
    F_x = 1 - (1 / returnPeriod)
    # Reduced gumbel variable
    u = -log(-log(F_x))

    Xn = b*u + a 
    return (Xn)
}


## 2. LOG NORMAL _____________________________________________________
#' Calculation of a value according to a return period according to a Galton distribution (log-normal)
#' @param X [numeric] vector of annual data to process
#' @param returnPeriod [numeric] Return period in years
#' @return The value for the return period according to Galton distribution
#' @export
compute_LogNormal = function(X, returnPeriod) {
    if (!is.numeric(returnPeriod)) {
        stop("returnPeriod must be of class 'numeric'")
    }
    if (returnPeriod <= 1) {
        stop("returnPeriod must be superior to 1")
    }
    X = X[!is.na(X)]
    nbY = length(X)
    if (nbY == 0) return(NA)
    Freq = 1 / returnPeriod
    nbXnul = length(X[X == 0])
    if ((nbXnul / nbY) <= Freq ) {
        Freq = Freq - (nbXnul / nbY)
        Xn = exp(qnorm(Freq) * sd(log(X[X > 0])) +
                 mean(log(X[X > 0])))
    } else {
        Xn = 0
    }
    return (Xn)
}


## 3. USE ____________________________________________________________
get_Xn = function (X, returnPeriod, waterType='low') {
    if (waterType == "high") {
        res = compute_GumbelParams(X)
        a = res$a
        b = res$b
        Xn = compute_GumbelLaw(a, b, returnPeriod)
    } else if (waterType == "low") {
        ### /!\ VCNn-n do no give same results between ashes and
        ### SeineBassin2. It is due to difference in NA positionning
        ### when there is missing values.
        Xn = compute_LogNormal(X, returnPeriod)
    }
    return (Xn)
} 
