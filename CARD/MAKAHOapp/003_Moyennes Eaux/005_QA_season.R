CARD$P.var = c("QA_DJF", "QA_MAM", "QA_JJA", "QA_SON")
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Débit hivernal annuel", "Débit printanier annuel",
                 "Débit estival annuel", "Débit automnal annuel")
CARD$P.topic = c("Débit", "Moyennes Eaux", "Liés à une statistique")

CARD$P1.funct = list(QA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
