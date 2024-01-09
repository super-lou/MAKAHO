CARD$P.var = "tVCX3"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = "#893687 #BC66A5 #E596C3 #EAC5DD #EFE2E9 #F5E4E2 #F2D7B5 #E9BD6F #DC8C48 #CD5629"
CARD$P.glose = "Date du maximum annuel de la moyenne sur 3 jours du débit journalier"
CARD$P.topic = c("Débit", "Hautes Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"

CARD$P1.funct = list(VC3=rollmean_center)
CARD$P1.funct_args = list("Q", k=3)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(tVCX3=which.maxNA)
CARD$P2.funct_args = list("VC3")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P2.isDate = TRUE
CARD$P2.NApct_lim = 3
