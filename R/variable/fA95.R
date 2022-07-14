var = "fA95"
type = "sévérité"
unit = "an^{-1}"
glose = "Fréquence annuelle (Q > Q95)"
event = "Crue"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

compute_fAp = function (Q, p) {
    Qp = compute_Qp(Q, p)
    n = sum(as.numeric(Q[!is.na(Q)] > Qp))
    N = length(Q)
    fA = n/N
    return (fA)
}

compute_Qp = function (Q, p) {
    Qp = quantile(Q[!is.na(Q)], p)
    return (Qp)
}

functY = compute_fAp
functY_args = list(p=0.95)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
