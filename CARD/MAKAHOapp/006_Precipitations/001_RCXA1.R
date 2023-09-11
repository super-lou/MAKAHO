CARD$P.var = "RCXA1"
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Maximum annuel des précipitations journalières"
CARD$P.topic = c("Précipitations", "Forte")
CARD$P.samplePeriod = "Mois du minimum des précipitations mensuelles"
    
CARD$P1.funct = list(RCXA1=maxNA)
CARD$P1.funct_args = list("P", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("P", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
