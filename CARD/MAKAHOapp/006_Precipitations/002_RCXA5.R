CARD$P.var = "RCXA5"
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Maximum annuel du cumul sur 5 jours des précipitations journalières"
CARD$P.topic =  c("Précipitations", "Forte")
CARD$P.samplePeriod = "Mois du minimum des précipitations mensuelles"
    
CARD$P1.funct = list(RC5=rollsum_center)
CARD$P1.funct_args = list("P", k=5)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(RCXA5=maxNA)
CARD$P2.funct_args = list("RC5", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(min, list("P", na.rm=TRUE))
CARD$P2.NApct_lim = 3
