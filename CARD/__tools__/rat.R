# Copyright 2021 Leonard Santos (leonard.santos@inrae.fr)*1,
#           2022-2023 Louis Héraut (louis.heraut@inrae.fr)*1
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


#  ___        _   
# | _ \ __ _ | |_ 
# |   // _` ||  _|
# |_|_\\__,_| \__| ___________________________________________________
compute_RAT_X = function (Bias, X, thresh=0.05) {
    isNA_Bias = is.na(Bias)
    isNA_X = is.na(X)
    isNA = isNA_X | isNA_Bias
    if (sum(!isNA) <= 2) {
        return (NA)
    }    
    Cor_X  = cor.test(x=Bias[!isNA],
                      y=X[!isNA],
                      method="spearman", continuity=FALSE,
                      exact=FALSE,
                      alternative="two.sided")$p.value
    RAT_X  = Cor_X < thresh    
    return (RAT_X)
}
