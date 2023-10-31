CARD$P.var = "moyRA"
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Moyenne des cumuls des précipitations totales annuelles"
CARD$P.topic = c("Précipitations", "Modérée")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(RA=sumNA)
CARD$P1.funct_args = list("R", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(moyRA=mean)
CARD$P2.funct_args = list("RA", na.rm=TRUE)
CARD$P2.timeStep = "none"
