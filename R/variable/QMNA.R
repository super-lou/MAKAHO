var = "QMNA"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Minimum annuel de la moyenne mensuelle du débit journalier"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = mean
functM_args = list(na.rm=TRUE)
isDateM = FALSE

minNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (min(X, na.rm=na.rm))
    }
}

functY = minNA
functY_args = list(na.rm=TRUE)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
