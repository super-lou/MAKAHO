ASHES$P.var = "v_BF"
ASHES$P.unit = "hm^{3}"
ASHES$P.glose = "Volume des écoulements lents (volume de l’intégrale sous la courbe du débit de base)"
ASHES$P.event = "Crue Nivale"

ASHES$P1.funct = list(X=compute_VolSnowmelt)
ASHES$P1.funct_args = list("Q")
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '09-01'
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
