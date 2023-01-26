CARD$P.var = "QNA"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.glose = "Minimum annuel du débit journalier"
CARD$P.topic = "Basses Eaux"
CARD$P.samplePeriod = '01-01'
    
CARD$P1.funct = list(X=minNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '01-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

