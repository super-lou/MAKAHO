var = "Q90"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Décile Q90 (débits classés)"
event = "Moyennes Eaux"
hydroPeriod = c("09-01", "08-31")

NAyear_lim = 10
NApct_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_Qp
functY_args = list(p=0.9)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
