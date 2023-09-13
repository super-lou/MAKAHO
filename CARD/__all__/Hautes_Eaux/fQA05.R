CARD$P.var = "fQA05"
CARD$P.unit = "jour.an^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Fréquence annuelle de dépassement (Q > Q05)"
CARD$P.topic = c("Débit", "Hautes Eaux")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"
    
CARD$P1.funct = list(lowLim=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.05)
CARD$P1.timeStep = "none"
CARD$P1.NApct_lim = NULL
CARD$P1.NAyear_lim = 10
CARD$P1.keep = "all"

CARD$P2.funct = list(fQA05=compute_fAp)
CARD$P2.funct_args = list("Q", lowLim="lowLim")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
