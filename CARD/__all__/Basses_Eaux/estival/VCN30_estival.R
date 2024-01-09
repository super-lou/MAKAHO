CARD$P.var = "VCN30_estival"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Minimum estival de la moyenne sur 30 jours du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = c("05-01", "11-30")
     
CARD$P1.funct = list(VC30_estival=rollmean_center)
CARD$P1.funct_args = list("Q", k=30)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(VCN30_estival=minNA)
CARD$P2.funct_args = list("VC30_estival", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c("05-01", "11-30")
CARD$P2.NApct_lim = 3
