var = "v_BF"
type = "Volume"
unit = "m^{3}"
glose = "Volume des écoulements lents (volume de l’intégrale sous la courbe du débit de base)"
event = "Crue Nivale"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_VolSnowmelt
functY_args = NULL
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
