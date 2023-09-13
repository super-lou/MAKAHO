CARD$P.var = "med{debutBE}"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Médiane du début des basses eaux, date de la première moyenne sur 10 jours sous le maximum des minimums annuels de la moyenne sur 10 jours du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"

CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"

CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10", na.rm=TRUE)
CARD$P3.timeStep = "none"
CARD$P3.keep = "all"

CARD$P4.funct = list(debutBE=apply_threshold)
CARD$P4.funct_args = list("VC10",
                          lim="upLim",
                          where="<=",
                          what="first",
                          select="longest")
CARD$P4.timeStep = "year"
CARD$P4.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P4.isDate = TRUE
CARD$P4.NApct_lim = 3

CARD$P5.funct = list("med{debutBE}"=circular_median)
CARD$P5.funct_args = list("debutBE", periodicity=365.25, na.rm=TRUE)
CARD$P5.timeStep = "none"
