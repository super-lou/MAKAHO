var = "tDEB_BF"
type = "saisonnalité"
unit = "jour de l'année"
glose = "Début des écoulements lents (date lorsque 10% de l’intégrale sous la courbe du débit de base est atteinte)"
event = "Crue Nivale"

NAyear_lim = 10
NApct_lim = 3

functY = compute_tVolSnowmelt
functY_args = list(p=0.1)
isDateY = TRUE
samplePeriodY = "09-01"
