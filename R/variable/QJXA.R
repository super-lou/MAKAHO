var = "QJXA"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Maximum annuel du débit journalier"
event = "Crue"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

maxNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (max(X))
    }
}

functY = maxNA
functY_args = list(na.rm=TRUE)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
