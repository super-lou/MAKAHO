CARD$P.var = "QMNA"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.glose = "Minimum annuel des débits mensuels"
CARD$P.topic = "Basses Eaux"
CARD$P.samplePeriod = c('05-01', '11-30')

CARD$P1.funct = list(Q=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(X=minNA)
CARD$P2.funct_args = list("Q", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c('05-01', '11-30')
CARD$P2.NApct_lim = 3
