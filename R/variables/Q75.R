ASHES$P.var = "Q75"
ASHES$P.unit = "m^{3}.s^{-1}"
ASHES$P.glose = "Débit seuil avec une probabilité de dépassement de 75% (centile 25%)"
ASHES$P.event = "Moyennes Eaux"

ASHES$P1.funct = list(X=compute_Qp)
ASHES$P1.funct_args = list("Q", p=0.75)
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '09-01'
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
