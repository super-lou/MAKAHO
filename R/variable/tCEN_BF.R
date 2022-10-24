var = "tCEN_BF"
type = "saisonnalité"
unit = "jour de l'année"
glose = "Centre des écoulements lents (date lorsque 50% de l’intégrale sous la courbe du débit de base est atteinte)"
event = "Crue Nivale"
hydroPeriod = c("09-01", "08-31")

NAyear_lim = 10
NApct_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_tVolSnowmelt
functY_args = list(p=0.5)
isDateY = TRUE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
