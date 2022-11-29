ASHES$P.var = "tDEB_BF"
ASHES$P.unit = "jour de l'année"
ASHES$P.glose = "Début des écoulements lents (date lorsque 10% de l’intégrale sous la courbe du débit de base est atteinte)"
ASHES$P.event = "Crue Nivale"

ASHES$P1.funct = list(X=compute_tVolSnowmelt)
ASHES$P1.funct_args = list("Q", p=0.1)
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '09-01'
ASHES$P1.isDate = TRUE
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
