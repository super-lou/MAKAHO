CARD$P.var = "RCXA5"
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Maximum annuel du cumul sur 5 jours des précipitations journalières"
CARD$P.topic =  c("Précipitations", "Forte")
CARD$P.samplePeriod = "Mois du minimum des précipitations mensuelles"
    
CARD$P1.funct = list(RC5=rollsum_center)
CARD$P1.funct_args = list("R", k=5)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(RCXA5=maxNA)
CARD$P2.funct_args = list("RC5", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(min, list("R", na.rm=TRUE))
CARD$P2.NApct_lim = 3
