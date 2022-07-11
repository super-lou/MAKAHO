var = "Q25"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Décile Q25 (débits classés)"
event = "Moyennes Eaux"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

compute_Qp = function (Q, p) {
    Qp = quantile(Q[!is.na(Q)], p)
    return (Qp)
}

functY = compute_Qp
functY_args = list(p=0.25)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
