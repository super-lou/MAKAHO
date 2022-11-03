var = "t_BF"
type = "saisonnalité"
unit = "jour"
glose = "Durée des écoulements lents (durée entre 10% et 90% de l’intégrale sous la courbe du débit de base)"
event = "Crue Nivale"

NAyear_lim = 10
NApct_lim = 3

functY = compute_tSnowmelt
functY_args = list(p1=0.1, p2=0.9)
samplePeriodY = "09-01"
