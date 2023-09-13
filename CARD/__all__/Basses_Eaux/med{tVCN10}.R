CARD$P.var = "med{tVCN10}"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Mediane des centres des basses eaux, dates des minimums annuels de la moyenne sur 10 jours du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"
    
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(tVCN10=which.minNA)
CARD$P2.funct_args = list("VC10")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P2.isDate = TRUE
CARD$P2.NApct_lim = 3

CARD$P3.funct = list("med{tVCN10}"=circular_median)
CARD$P3.funct_args = list("tVCN10", periodicity=365.25, na.rm=TRUE)
CARD$P3.timeStep = "none"
