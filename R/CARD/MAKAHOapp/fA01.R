CARD$P.var = "fA01"
CARD$P.unit = "jour.an^{-1}"
CARD$P.glose = "Fréquence annuelle de dépassement (Q > Q01)"
CARD$P.topic = "Crue"
CARD$P.samplePeriod = '09-01'
    
CARD$P1.funct = list(lowLim=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.01)
CARD$P1.timeStep = "none"
CARD$P1.NApct_lim = NULL
CARD$P1.NAyear_lim = 10
CARD$P1.keep = TRUE

CARD$P2.funct = list(X=compute_fAp)
CARD$P2.funct_args = list("Q", lowLim="lowLim")
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = "09-01"
CARD$P2.NApct_lim = 3
CARD$P2.rmNApct = FALSE
