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


#  ___                        _            
# | _ \ ___  __  ___  ___ ___(_) ___  _ _  
# |   // -_)/ _|/ -_)(_-<(_-<| |/ _ \| ' \ 
# |_|_\\___|\__|\___|/__//__/|_|\___/|_||_| __________________________
## 1. RECESSION EVENTS _______________________________________________
#' @title recession_events_index
#' @description Extracts the index of the start and end of each
#' recession events, returned in a two columns data.frame
#' @param Q Streamflow vector
#' @param minduration minimum duration of a recession event
#' @param maxduration maximum duration of a recession event
#' @param minvalue minimum streamflow value to consider a local
#' maximum as a potential start of a recession event
#' @param n_smooth the number of time the rolling mean should be
#' applied
#' @param window_smooth the size of the window to apply the rolling
#' mean
#' @param return_smoothed should the smoothed streamlfow values be
#' returned as well ? Warning: instead of a data.frame, a list with
#' two components (Q_smoothed and i_events) is returned.
recession_events_index = function (Q, minduration, maxduration,
                                   minvalue, n_smooth, window_smooth,
                                   return_smoothed=FALSE) {
    # optional smooting of Q
    if (n_smooth > 0) {
        for (k in 1:n_smooth) {
            Q = roll_mean(x = Q, n = window_smooth, fill = NA, align = "center")
        }
    }
    # find local maxima and minima
    minmax = diff(sign(diff(Q)))
    ismax = c(FALSE, minmax < 0, FALSE)
    # ismin = c(FALSE, minmax > 0, FALSE)
    ismin = c(FALSE, minmax > 0 | is.na(minmax), FALSE)
    # select those above a certain Q threshold
    ismaxenough = Q > minvalue
    ismax = ismax & ismaxenough
    # find end of recessions from minima and create event data.frame
    imax = c(which(ismax), length(Q))
    imin = which(ismin)
    # here some magic is done in C++ to find the minima following 
    # each local maxima (if any)
    ievents = data.frame(Start=imax, End=rec_events(imax, imin))
    # remove events with no end
    ievents = ievents[!is.na(ievents[, 2L]), ]
    # remove events that are too short 
    eventlength = apply(ievents, 1, diff) + 1
    ievents = ievents[eventlength >= minduration, ]
    # truncate events that are too long
    eventlength = apply(ievents, 1, diff) + 1
    toolong = eventlength >= maxduration
    ievents[toolong, 2] = ievents[toolong, 1L] + maxduration - 1
    if (return_smoothed) {
        return (list(Q_smoothed=Q, i_events=ievents))
    } else {
        return (ievents)
    }
}


## 2. RECESSION TIMES ________________________________________________
# a faster version (50 times faster) of the lm() function
# see ?.lm.fit
.hsaFastLm = function(x, y) {
    x = cbind(1, x)
    .lm.fit(x, y)
}

#' @title recession_times
#' @description Fits exponential models to individual segments of the
#' extracted recessions and compute the correseponding recession times
#' @param Q Streamflow vector (smoothed or unsmoothed)
#' @param i_events two-column data frame containing the index of the
#' start and end of each recession events
#' @param segments list containing the index vector to use to fit the
#' different segments.
#' @param n_min what is the minimal number of values required to try
#' to fit a recession event ? as a potential start of a recession
#' event
#' @param summary_fun A summary function to be applied on the
#' data.frame that contains all the recession times : anything else
#' than a function will return the data.frame.
#' @return
#' @export
recession_times = function(Q, i_events, segments=list(1L:5L, 15L:30L), n_min=5L, summary_fun=median, ...) {
    n_seg = length(segments)
    tau = matrix(NA, nrow(i_events), n_seg, dimnames = list(NULL, if (is.null(names(segments))) paste0("Tau", 1:n_seg) else names(segments)))
    Q_events = apply(i_events, 1, function(e) Q[e[1L]:e[2L]])
    for (k in 1:n_seg) {
        s = segments[[k]]
        Q_e = lapply(Q_events, function(e, s)  {
            e = e[s]
            e = e[e>0 & !is.na(e)]
            log(e)
        }, s = s)
        valid_Q_e = lengths(Q_e) >= n_min
        Q_e = Q_e[valid_Q_e]
        reg_res = lapply(Q_e, function(e) .hsaFastLm(1:length(e), e))
        tau[valid_Q_e, k] = -1 / unlist(lapply(reg_res, function(e) e$coefficients[2L]), use.names = FALSE)
    }
    if (is.function(summary_fun)) apply(tau, 2, summary_fun, ...) else as.data.frame(tau)
}
