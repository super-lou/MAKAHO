var = "fA99"
type = "sévérité"
unit = "jour.an^{-1}"
glose = "Fréquence annuelle (Q > Q99)"
event = "Crue"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_fAp
functY_args = list(lowLim='*threshold*')
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = compute_Qp
functYT_sum_args = list(p=0.99)
