CARD$P.var = "QNA_hivernal"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Minimum hivernal du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = c("11-01", "04-30")
    
CARD$P1.funct = list(QNA_hivernal=minNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = c("11-01", "04-30")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
