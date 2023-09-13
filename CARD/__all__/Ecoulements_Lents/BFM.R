CARD$P.var = "BFM"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Baseflow magnitude"
CARD$P.topic = c("Débit", "Écoulements Lents", "Signature hydrologique")

CARD$P1.funct = list(BF=BFS)
CARD$P1.funct_args = list("Q")
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(BFA=mean)
CARD$P2.funct_args = list("BF", na.rm=TRUE)
CARD$P2.timeStep = "yearday"
CARD$P2.NApct_lim = 3

CARD$P3.funct = list(BFM=get_BFM)
CARD$P3.funct_args = list("BFA")
CARD$P3.timeStep = "none"
