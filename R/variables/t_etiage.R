ASHES$P.var = "t_etiage"
ASHES$P.unit = "jour"
ASHES$P.glose = "Durée de l'étiage (durée de la plus longue période continue de la moyenne sur 10 jours sous le maximum des VCN10)"
ASHES$P.event = "Étiage"

ASHES$P1.funct = list(Q=rollmean_center)
ASHES$P1.funct_args = list("Q", k=10)
ASHES$P1.timeStep = "none"
ASHES$P1.keep = TRUE

ASHES$P2.funct = list(Qmin=minNA)
ASHES$P2.funct_args = list("Q", na.rm=TRUE)
ASHES$P2.timeStep = "year"
ASHES$P2.samplePeriod = c('05-01', '11-30')
ASHES$P2.NApct_lim = 3
ASHES$P2.NAyear_lim = 10
ASHES$P2.keep = TRUE

ASHES$P3.funct = list(UpLim=maxNA)
ASHES$P3.funct_args = list("Qmin", na.rm=TRUE)
ASHES$P3.timeStep = "none"
ASHES$P3.keep = TRUE

ASHES$P4.funct = list(X=under_threshold)
ASHES$P4.funct_args = list("Q", what="length", select_longest=TRUE, UpLim="UpLim")
ASHES$P4.timeStep = "year"
ASHES$P4.samplePeriod = c('05-01', '11-30')
ASHES$P4.isDate = TRUE
ASHES$P4.NApct_lim = 3
ASHES$P4.NAyear_lim = 10
ASHES$P4.rmNApct = FALSE
