CARD$P.var = "tCEN_etiage"
CARD$P.unit = "jour de l'année"
CARD$P.glose = "Centre d'étiage (jour de l'année du VCN10)"
CARD$P.topic = "Étiage"
CARD$P.samplePeriod = c('05-01', '11-30')
    
CARD$P1.funct = list(Q=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = TRUE

CARD$P2.funct = list(X=which.minNA)
CARD$P2.funct_args = list("Q")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c('05-01', '11-30')
CARD$P2.isDate = TRUE
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.rmNApct = FALSE
