CARD$P.var = "tDEB_etiage"
CARD$P.unit = "jour de l'année"
CARD$P.glose = "Début d'étiage (jour de l'année de la première moyenne sur 10 jours sous le maximum des VCN10)"
CARD$P.topic = "Basses Eaux"
CARD$P.samplePeriod = c('05-01', '11-30')
    
CARD$P1.funct = list(Q=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"

CARD$P2.funct = list(Qmin=minNA)
CARD$P2.funct_args = list("Q", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = c('05-01', '11-30')
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("Qmin", na.rm=TRUE)
CARD$P3.timeStep = "none"
CARD$P3.samplePeriod = c('05-01', '11-30')
CARD$P3.keep = "all"

CARD$P4.funct = list(X=apply_threshold)
CARD$P4.funct_args = list("Q",
                           lim="upLim",
                           where="under",
                           what="first",
                           select="longest")
CARD$P4.timeStep = "year"
CARD$P4.samplePeriod = c('05-01', '11-30')
CARD$P4.isDate = TRUE
CARD$P4.NApct_lim = 3

