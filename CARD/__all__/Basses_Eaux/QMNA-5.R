CARD$P.var = "QMNA-5"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Minimum annuel des débits mensuels de période de retour 5 ans"
CARD$P.topic = c("Débit", "Basses Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"
    
CARD$P1.funct = list(QMA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(QMNA=minNA)
CARD$P2.funct_args = list("QMA", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("QMA", na.rm=TRUE))
CARD$P2.NApct_lim = 3

CARD$P3.funct = list("QMNA-5"=get_Xn)
CARD$P3.funct_args = list("QMNA",
                          returnPeriod=5,
                          waterType="low")
CARD$P3.timeStep = "none"
