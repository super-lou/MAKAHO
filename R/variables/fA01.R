ASHES$P.var = "fA01"
ASHES$P.unit = "jour.an^{-1}"
ASHES$P.glose = "Fréquence annuelle de dépassement (Q > Q01)"
ASHES$P.event = "Crue"

ASHES$P1.funct = list(lowLim=compute_Qp)
ASHES$P1.funct_args = list("Q", p=0.01)
ASHES$P1.timeStep = "none"
ASHES$P1.NApct_lim = 3
ASHES$P1.NAyear_lim = 10
ASHES$P1.keep = TRUE

ASHES$P2.funct = list(X=compute_fAp)
ASHES$P2.funct_args = list("Q", lowLim="lowLim")
ASHES$P2.timeStep = "year"
ASHES$P2.samplePeriod = "09-01"
ASHES$P2.NApct_lim = 3
ASHES$P2.NAyear_lim = 10
ASHES$P2.rmNApct = FALSE
