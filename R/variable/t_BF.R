var = "t_BF"
type = "saisonnalité"
unit = "jour"
glose = "Durée des écoulements lents (durée entre 10% et 90% de l’intégrale sous la courbe du débit de base)"
event = "Crue Nivale"
hydroPeriod = c("09-01", "08-31")

NAyear_lim = 10
NApct_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_tSnowmelt
functY_args = list(p1=0.1, p2=0.9)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
