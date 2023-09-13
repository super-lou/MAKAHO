CARD$P.var = "RCXA1"
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Maximum annuel des précipitations journalières"
CARD$P.topic = c("Précipitations", "Forte")
CARD$P.samplePeriod = "Mois du minimum des précipitations mensuelles"
    
CARD$P1.funct = list(RCXA1=maxNA)
CARD$P1.funct_args = list("P", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("P", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
