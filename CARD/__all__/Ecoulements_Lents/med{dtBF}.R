CARD$P.var = "med{dtBF}"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Médiane de la durée des écoulements lents, durée entre le début et la fin des écoulements lents"
CARD$P.topic = c("Débit", "Écoulements Lents")
CARD$P.samplePeriod = '09-01'

CARD$P1.funct = list(dtBF=compute_tSnowmelt)
CARD$P1.funct_args = list("Q", p1=0.1, p2=0.9)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("med{dtBF}"=median)
CARD$P2.funct_args = list("dtBF", na.rm=TRUE)
CARD$P2.timeStep = "none"
