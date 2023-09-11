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


#  ___             __                                       
# | _ \ ___  _ _  / _| ___  _ _  _ __   __ _  _ _   __  ___ 
# |  _// -_)| '_||  _|/ _ \| '_|| '  \ / _` || ' \ / _|/ -_)
# |_|  \___||_|  |_|  \___/|_|  |_|_|_|\__,_||_||_|\__|\___| _________
## 1. BIAS ___________________________________________________________
#' @title Biais
#' @description Computes the bias (unitless) between simulated and
#' observed data
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @param sim_minus_obs: should it be sim - obs ? (or the other way
#' around)
compute_Biais = function(obs, sim, na.rm=TRUE, sim_minus_obs=TRUE) {
    if (length(obs) != length(sim)) {
        stop("obs and sim must have the same length")
    }
    if (na.rm) {
        isna = is.na(obs) | is.na(sim)
        obs = obs[!isna]
        sim = sim[!isna]
    }
    if (sim_minus_obs) {
        Biais = sum(sim - obs) / sum(obs)
    } else {
        Biais = sum(obs - sim) / sum(obs)
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
compute_NSE = function (obs, sim, na.rm=TRUE) {
    if (na.rm) {
        isna = is.na(obs) | is.na(sim)
        obs = obs[!isna]
        sim = sim[!isna]
    }
    NSE = 1 - sum((sim - obs)^2) / sum((obs - mean(obs))^2)
    return (NSE)
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
compute_hsaLog = function (x, method="inf.na") {
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
#' and the 'NSE' function
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @param log_method See 'hsaLog'
#' @return NSElog according to parametrization
#' @export
compute_NSElog = function (obs, sim, na.rm=TRUE, log_method="inf.na") {
    if (sum(obs != 0, na.rm=TRUE) > 0 &
        sum(sim != 0, na.rm=TRUE) > 0) {
        obs = compute_hsaLog(obs, method=log_method)
        sim = compute_hsaLog(sim, method=log_method)
        NSElog = compute_NSE(obs=obs, sim=sim, na.rm=na.rm)
    } else {
        NSElog = 0
    }
    return (NSElog)
}

#' @title NSEi
#' @description Computes the Nash-Sutcliffe efficiency coefficient on
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @return NSEi according to parametrization
#' @export
compute_NSEi = function (obs, sim, na.rm=TRUE) {
    if (sum(obs != 0, na.rm=TRUE) > 0 &
        sum(sim != 0, na.rm=TRUE) > 0) {
        obs = 1/obs
        sim = 1/sim
        NSEi = compute_NSE(obs=obs, sim=sim, na.rm=na.rm)
    } else {
        NSEi = NA 
    }
    return (NSEi)
}

#' @title NSEracine
#' @description Computes the Nash-Sutcliffe efficiency coefficient on
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @return NSEracine according to parametrization
#' @export
compute_NSEracine = function (obs, sim, na.rm=TRUE) {
    obs = sqrt(obs)
    sim = sqrt(sim)
    NSEracine = compute_NSE(obs=obs, sim=sim, na.rm=na.rm)
    return (NSEracine)
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
compute_KGE = function (obs, sim, na.rm=TRUE, method=1) {
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
        KGE = compute_KGE_short(R=rso, AG=ALPHA, BETA=BETA)
    } else if (method == 2){
        cvobs = sobs / mobs
        cvsim = ssim / msim
        GAMMA = cvsim / cvobs
        KGE = compute_KGE_short(R=rso, AG=GAMMA, BETA=BETA)
    }  else {
        warning("Unknown method, only 1 and 2 are supported. Default method 1 used.")
        KGE = compute_KGE_short(R=rso, AG=ALPHA, BETA=BETA)
    }
    return (KGE)
}

# An intermediate function in the computation of KGE.
# Here only to avoid code repetition
compute_KGE_short = function (R, AG, BETA) {
    1 - sqrt((R-1)^2 + (AG-1)^2 + (BETA-1)^2)
}

#' @title KGEracine
#' @description Computes the
#' @param obs Observed streamflow vector
#' @param sim Simulated streamflow vector
#' @param na.rm Should missing values be omited ?
#' @return KGEracine according to parametrization
#' @export
compute_KGEracine = function (obs, sim, na.rm=TRUE) {
    obs = sqrt(obs)
    sim = sqrt(sim)
    KGEracine = compute_KGE(obs=obs, sim=sim, na.rm=na.rm)
    return (KGEracine)
}


#' @title STD
#' @export
compute_STD = function (obs, sim, na.rm=TRUE) {
    STD = sd(sim, na.rm=na.rm) / sd(obs, na.rm=na.rm)
    return (STD)
}
