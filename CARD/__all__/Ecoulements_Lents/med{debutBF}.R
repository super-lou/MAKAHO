CARD$P.var = "med{debutBF}"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Médiane du début des écoulements lents, date à laquelle 10% de l’intégrale sous la courbe du débit de base est atteinte"
CARD$P.topic = c("Débit", "Écoulements Lents")
CARD$P.samplePeriod = '09-01'
    
CARD$P1.funct = list(debutBF=compute_tVolSnowmelt)
CARD$P1.funct_args = list("Q", p=0.1)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.isDate = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("med{debutBF}"=circular_median)
CARD$P2.funct_args = list("debutBF", periodicity=365.25, na.rm=TRUE)
CARD$P2.timeStep = "none"
