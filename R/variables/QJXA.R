ASHES$P.var = "QJXA"
ASHES$P.unit = "m^{3}.s^{-1}"
ASHES$P.glose = "Maximum annuel du débit journalier"
ASHES$P.event = "Crue"

ASHES$P1.funct = list(X=maxNA)
ASHES$P1.funct_args = list("Q", na.rm=TRUE)
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = '09-01'
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.rmNApct = FALSE
