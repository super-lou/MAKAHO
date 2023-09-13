CARD$P.var = "QJC10"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Débit moyen mensuel moyenné sur 10 jours"
CARD$P.topic = c("Débit", "Moyennes Eaux")
    
CARD$P1.funct = list(QJ=mean)
CARD$P1.funct_args = list("Q_obs", na.rm=TRUE)
CARD$P1.timeStep = "yearday"
CARD$P1.keep = "all"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(QJC10=rollmean_center)
CARD$P2.funct_args = list("QJ", k=10, isCyclical=TRUE)
CARD$P2.timeStep = "none"
CARD$P2.keep = c("QJC10")
