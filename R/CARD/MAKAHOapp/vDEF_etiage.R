CARD$P.var = "vDEF_etiage"
CARD$P.unit = "hm^{3}"
CARD$P.glose = "Volume de déficite de l'étiage (intégrale de la courbe de la moyenne sur 10 jours sous le maximum des VCN10)"
CARD$P.topic = "Étiage"
CARD$P.samplePeriod = c('05-01', '11-30')

CARD$P1.funct = list(Q=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = TRUE

CARD$P2.funct = list(Qmin=minNA)
CARD$P2.funct_args = list("Q", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c('05-01', '11-30')
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = TRUE

CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("Qmin", na.rm=TRUE)
CARD$P3.timeStep = "none"
CARD$P3.samplePeriod = c('05-01', '11-30')
CARD$P3.keep = TRUE

CARD$P4.funct = list(X=compute_VolDef)
CARD$P4.funct_args = list("Q", select="longest", upLim="upLim")
CARD$P4.timeStep = "year"
CARD$P4.samplePeriod = c('05-01', '11-30')
CARD$P4.NApct_lim = 3
CARD$P4.rmNApct = FALSE
