CARD$P.var = "CDC"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Courbe des débits classés"
CARD$P.topic = c("Débit", "Moyennes Eaux")

CARD$P1.funct = list(CDC_p=compute_FDC_p,
                     CDC_Q=compute_FDC_Q)
CARD$P1.funct_args = list(list(n=1000, isNormLaw=TRUE),
                          list("Q", n=1000, isNormLaw=TRUE))
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
