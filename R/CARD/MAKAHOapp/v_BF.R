CARD$P.var = "v_BF"
CARD$P.unit = "hm^{3}"
CARD$P.glose = "Volume des écoulements lents (intégrale sous la courbe du débit de base)"
CARD$P.topic = "Écoulements Lents"
CARD$P.samplePeriod = '09-01'

CARD$P1.funct = list(X=compute_VolSnowmelt)
CARD$P1.funct_args = list("Q")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.rmNApct = FALSE
