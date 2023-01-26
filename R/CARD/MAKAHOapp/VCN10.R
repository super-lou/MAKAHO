CARD$P.var = "VCN10"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.glose = "Minimum annuel de la moyenne sur 10 jours du débit journalier"
CARD$P.topic = "Basses Eaux"
CARD$P.samplePeriod = c('05-01', '11-30')
     
CARD$P1.funct = list(Q=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"

CARD$P2.funct = list(X=minNA)
CARD$P2.funct_args = list("Q", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c('05-01', '11-30')
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10

