ASHES$P.var = "t_BF"
ASHES$P.unit = "jour"
ASHES$P.glose = "Durée des écoulements lents (durée entre 10% et 90% de l’intégrale sous la courbe du débit de base)"
ASHES$P.event = "Crue Nivale"

ASHES$P1.funct = list(X=compute_tSnowmelt)
ASHES$P1.funct_args = list("Q", p1=0.1, p2=0.9)
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '09-01'
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
