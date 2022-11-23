# \\\
# Copyright 2021 Leonard Santos (leonard.santos@inrae.fr)*1,
#           2022 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
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


#  ___        _   
# | _ \ __ _ | |_ 
# |   // _` ||  _|
# |_|_\\__,_| \__| ___________________________________________________
#' @title RAT
#' @description Function to apply RAT to simulated and observed
#' streamflows. Missing values in observed data must be NA.
#' @param Dates Date vector with a date format (at daily time step)
#' @param Qobs Observed streamflows vector [mm/d]
#' @param Qsim Simulated streamflows vector [mm/d]
#' @param Pobs Observed precipitation vector [mm/d]
#' @param Tobs Observed temperature vector [mm/d]
#' @param Eobs Observed potential evapotranspiration vector [mm/d]
#' @param Thresh Value of the significance threshold to use for the
#' correlation test
#' @return RAT
#' @export
compute_RAT = function (Dates, Qobs, Qsim, Pobs, Tobs, Eobs,
                        Thresh=0.05) {
    # --- Step 1: aggregate data on hydrological years
    # Grep first day of hydrological years indexes in the date vector
    Indd = grep(pattern="10-01", x=substr(Dates, 6, 10))
    # Create a vector of the hydrological year number with the same
    # length of Dates vector
    Indd_hydYear = rep(0, length(Dates))
    for (k in seq_along(Indd[-1])) {
        Indd_hydYear[seq(Indd[k], Indd[k+1]-1)] = k
    }
    # Initialise the vectors of yearly data
    Qobs_year = rep(NaN, length(Indd[-1]))
    Qsim_year = rep(NaN, length(Indd[-1]))
    Pobs_year = rep(NaN, length(Indd[-1]))
    Tobs_year = rep(NaN, length(Indd[-1]))
    Eobs_year = rep(NaN, length(Indd[-1]))
    # Aggregate the vectors of entry
    for (k in seq_along(Indd[-1])) {
        Qobs_year[k] = sum(Qobs[Indd_hydYear == k])
        Qsim_year[k] = sum(Qsim[Indd_hydYear == k])
        Pobs_year[k] = sum(Pobs[Indd_hydYear == k])
        Tobs_year[k] = sum(Tobs[Indd_hydYear == k])
        Eobs_year[k] = sum(Eobs[Indd_hydYear == k])
    }
    # --- Step 2: calculate the yearly bias of the model
    Bias_year = Qsim_year/Qobs_year - 1
    # --- Step 3: check corrleation between climatic varible and bias
    # Calculate pvalues of Spearman correlation tests
    Cor_P  = cor.test(x=Bias_year[!is.na(Bias_year)],
                      y=Pobs_year[!is.na(Bias_year)],
                      method="spearman", continuity=FALSE,
                      alternative="two.sided")$p.value
    Cor_T  = cor.test(x=Bias_year[!is.na(Bias_year)],
                      y=Tobs_year[!is.na(Bias_year)],
                      method="spearman", continuity=FALSE,
                      alternative="two.sided")$p.value
    Cor_PE = cor.test(x=Bias_year[!is.na(Bias_year)],
                      y=(Pobs_year/Eobs_year)[!is.na(Bias_year)],
                      method="spearman", continuity=FALSE,
                      alternative="two.sided")$p.value
    # Computa RAT result
    RAT_P  = Cor_P < Thresh
    RAT_T  = Cor_T < Thresh
    RAT_PE = Cor_PE < Thresh
    # --- Step 4: return the result of the RAT
    # TRUE means that there is a dependency to the variable (i.e. the
    # model is not robust)
    # FALSE means that there is no dependency to the variable (i.e.
    # the model does not fail to the robustness, 
    # but of course the robustness is not guaranteed)
    res = c(Cor_P, Cor_T, Cor_PE, RAT_P, RAT_T, RAT_PE)
    return (res)
}
