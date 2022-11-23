ASHES$P.var = "QMNA"
ASHES$P.unit = "m^{3}.s^{-1}"
ASHES$P.glose = "Minimum annuel de la moyenne mensuelle du débit journalier"
ASHES$P.event = "Étiage"

ASHES$P1.funct = list(Q=mean)
ASHES$P1.funct_args = list("Q", na.rm=TRUE)
ASHES$P1.timeStep = "year-month"
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10

ASHES$P2.funct = list(X=minNA)
ASHES$P2.funct_args = list("Q", na.rm=TRUE)
ASHES$P2.timeStep = "year"
ASHES$P2.samplePeriod = c('05-01', '11-30')
ASHES$P2.NApct_lim = 3
ASHES$P2.NAyear_lim = 10
ASHES$P2.rmNApct = FALSE
