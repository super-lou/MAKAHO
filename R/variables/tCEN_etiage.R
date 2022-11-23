ASHES$P.var = "tCEN_etiage"
ASHES$P.unit = "jour de l'année"
ASHES$P.glose = "Centre d'étiage (jour de l'année du VCN10)"
ASHES$P.event = "Étiage"

ASHES$P1.funct = list(Q=rollmean_center)
ASHES$P1.funct_args = list("Q", k=10)
ASHES$P1.timeStep = "none"
ASHES$P1.keep = TRUE

ASHES$P2.funct = list(X=which.minNA)
ASHES$P2.funct_args = list("Q")
ASHES$P2.timeStep = "year"
ASHES$P2.samplePeriod = c('05-01', '11-30')
ASHES$P2.isDate = TRUE
ASHES$P2.NApct_lim = 3
ASHES$P2.NAyear_lim = 10
ASHES$P2.rmNApct = FALSE
