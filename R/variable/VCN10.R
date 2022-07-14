var = "VCN10"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Minimum annuel de la moyenne sur 10 jours du débit journalier"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = 10

functM = NULL
functM_args = NULL
isDateM = FALSE

minNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (min(X))
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
