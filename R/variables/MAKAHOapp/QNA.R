ASHES$P.var = "QNA"
ASHES$P.unit = "m^{3}.s^{-1}"
ASHES$P.glose = "Minimum annuel du débit journalier"
ASHES$P.event = "Étiage"

ASHES$P1.funct = list(X=minNA)
ASHES$P1.funct_args = list("Q", na.rm=TRUE)
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '01-01'
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
