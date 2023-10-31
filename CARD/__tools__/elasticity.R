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


#  ___  _            _    _      _  _         
# | __|| | __ _  ___| |_ (_) __ (_)| |_  _  _ 
# | _| | |/ _` |(_-<|  _|| |/ _|| ||  _|| || |
# |___||_|\__,_|/__/ \__||_|\__||_| \__| \_, | _______________________
#                                        |__/
#' @title Elasticity
#' @description To quote Yushiou Tsai (2016) :
#' "We used elasticity to assess the sensitivity of mean and drought
#' flows to changes in climate, land use and land cover (LULC), and
#' water use across a broad region. [...] Sankarasubramanian et al.
#' (2001) suggested (that) a bivariate empirical estimator for the
#' precipitation elasticity of mean flow".
#' This is this last estimator that is use in the below function.
#' @param Q
#' @param X
#' @return Elasticity given by :
#' eps_X = median((Q-Qmean)/(X-Xmean) * Xmean/Qmean)
#' @export
compute_elasticity = function (Q, X) {
    Qmean = mean(Q, na.rm=TRUE)
    Xmean = mean(X, na.rm=TRUE)
    eps_X = median((Q-Qmean)/(X-Xmean) * Xmean/Qmean, na.rm=TRUE)
    return (eps_X)
}

# compute_CI = function (X, level=0.90) {
#     # Calculate the mean and standard error
#     model = lm(X~1)
#     # Find the confidence interval
#     int = confint(model, level=level)
#     low = int[1]
#     up = int[2]
#     res = list(low=low, up=up)
#     return (res)
# }

# moyenne theorem central limite
# etiage loi log normal
# am10 am30
# elasitie variable debit annuel
# correlation croisé entre variable pour voir lesquels sont d'interet prendre exemple article Renard
