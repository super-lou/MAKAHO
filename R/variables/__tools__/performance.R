# \\\
# Copyright 2020 Ivan Horner (ivan.horner@irstea.fr)*1,
#           2022 Louis Héraut (louis.heraut@inrae.fr)*2
#
# *1   IRSTEA, France
# *2   INRAE, France
#
# This file is part of Ashes R package.
#
# Ashes R package is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Ashes R package is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ashes R package.
# If not, see <https://www.gnu.org/licenses/>.
# ///


#  ___             __                                       
# | _ \ ___  _ _  / _| ___  _ _  _ __   __ _  _ _   __  ___ 
# |  _// -_)| '_||  _|/ _ \| '_|| '  \ / _` || ' \ / _|/ -_)
# |_|  \___||_|  |_|  \___/|_|  |_|_|_|\__,_||_||_|\__|\___| _________
## 1. BIAS ___________________________________________________________
#' @title Bias
#' @description Computes the bias (unitless) between simulated and
#' observed data
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @param sim_minus_obs: should it be sim - obs ? (or the other way
#' around)
compute_bias = function(obs, sim, na.rm=TRUE, sim_minus_obs=TRUE) {
    if (length(obs) != length(sim)) {
        stop("obs and sim must have the same length")
    }
    if (na.rm) {
        isna = is.na(obs) | is.na(sim)
        obs = obs[!isna]
        sim = sim[!isna]
    }
    if (sim_minus_obs) {
        bias = sum(sim - obs) / sum(obs)
    } else {
        bias = sum(obs - sim) / sum(obs)
    }
}


## 2. COEFFICIENT OF DETERMINATION ___________________________________
#' @title R2
#' @description Computes the coefficient of determination using the
#' cor() function between simulated and observed data
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @param method The method to use in cor() function
#' @return R2
#' @export
compute_R2 = function(obs, sim, na.rm=TRUE,
                      method=c("pearson",
                               "kendall",
                               "spearman")) {
    if (na.rm) {
        use = "na.or.complete"
    } else {
        use = "everything"
    }
    R2 = cor(obs, sim, use = use, method = method)
    return (R2)
}


## 3. NASH-SUTCLIFFE EFFICIENCY ______________________________________
#' @title NSE
#' @description Computes the Nash-Sutcliffe efficiency coefficient
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @return 1 - sum((sim-obs)^2)/sum((obs-mean(obs))^2)
#' @export
compute_nse = function (obs, sim, na.rm=TRUE) {
    if (na.rm) {
        isna = is.na(obs) | is.na(sim)
        obs = obs[!isna]
        sim = sim[!isna]
    }
    nse = 1 - sum((sim - obs)^2) / sum((obs - mean(obs))^2)
    return (nse)
}

#' @title hsaLog
#' @description Computes the log transformed value of streamflow using
#' either the approach proposed by Pushpalatha et al. (2012), or by
#' adding any given value to all streamflow values or simply by
#' setting to NA any non finite value resulting from the application
#' of log().
#' @param x Any streamflow vector
#' @param method the method to use : 'Pushpalatha2012', a numeric
#' value (to be added to 'x') or 'inf.na'
#' @return log(x) according to parametrization
#' @export
compute_hsaLog = function (x, method="Pushpalatha2012") {
    if (method == "Pushpalatha2012") {
        x = x + mean(x, na.rm = TRUE) / 100
    } else if (is.numeric(method)) {
        x = x + method
    }
    if (method == "inf.na")  {
        y = suppressWarnings(log(x))
        y[!is.finite(y)] = NA
    } else {
        y = log(x)
    }
    return (y)
}

#' @title NSElog
#' @description Computes the Nash-Sutcliffe efficiency coefficient on
#' the log transformed streamflow values using the 'hsaLog' function
#' and the 'nse' function
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @param log_method See 'hsaLog'
#' @return NSElog according to parametrization
#' @export
compute_nselog = function (obs, sim, na.rm=TRUE, log_method="inf.na") {
    obs_log = compute_hsaLog(obs, method=log_method)
    sim_log = compute_hsaLog(sim, method=log_method)
    nselog = compute_nse(obs=obs_log, sim=sim_log, na.rm=na.rm)
    return (nselog)
}


## 4. KLING-GUPTA EFFICIENCY _________________________________________
#' @title KGE
#' @description Computes the Kling-Gupta efficiency coefficient. This
#' function was largely inspired by the similar function in the
#' HydroGOF package. Here, only a simplified version is provided with
#' no checks on inputs and very little formatting to speed it up.
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited?
#' @param method Two methods are implemented (see hydroGOF::KGE): '1'
#' for Gupta et al. (2009) and '2' for Kling et al. (2012)
#' @return KGE
#' @export
compute_kge = function (obs, sim, na.rm=TRUE, method=1) {
    if (na.rm) {
        isna = is.na(obs) | is.na(sim)
        obs = obs[!isna]
        sim = sim[!isna]
    }
    mobs = mean(obs)
    msim = mean(sim)
    sobs = sd(obs)
    ssim = sd(sim)
    rso  = cor(sim, obs)
    ALPHA = ssim / sobs
    BETA  = msim / mobs
    if (method == 1) {
        kge = compute_kge_short(R=rso, AG=ALPHA, BETA=BETA)
    } else if (method == 2){
        cvobs = sobs / mobs
        cvsim = ssim / msim
        GAMMA = cvsim / cvobs
        kge = compute_kge_short(R=rso, AG=GAMMA, BETA=BETA)
    }  else {
        warning("Unknown method, only 1 and 2 are supported. Default method 1 used.")
        kge = compute_kge_short(R=rso, AG=ALPHA, BETA=BETA)
    }
    return (kge)
}

# An intermediate function in the computation of KGE.
# Here only to avoid code repetition
compute_kge_short = function (R, AG, BETA) {
    1 - sqrt((R-1)^2 + (AG-1)^2 + (BETA-1)^2)
}
