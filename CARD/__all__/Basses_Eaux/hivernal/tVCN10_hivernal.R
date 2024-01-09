CARD$P.var = "tVCN10_hivernal"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = "#893687 #BC66A5 #E596C3 #EAC5DD #EFE2E9 #F5E4E2 #F2D7B5 #E9BD6F #DC8C48 #CD5629"
CARD$P.glose = "Centre des basses eaux hivernales, date du minimum annuel de la moyenne sur 10 jours du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = c("11-01", "04-30")
    
CARD$P1.funct = list(VC10_hivernal=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"

CARD$P2.funct = list(tVCN10_hivernal=which.minNA)
CARD$P2.funct_args = list("VC10_hivernal")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c("11-01", "04-30")
CARD$P2.isDate = TRUE
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
