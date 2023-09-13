CARD$P.var = "QJXA-10"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Maximums annuels des débits journaliers de période de retour 10 ans"
CARD$P.topic = c("Débit", "Hautes Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"
    
CARD$P1.funct = list(QJXA=maxNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("QJXA-10"=get_Xn)
CARD$P2.funct_args = list("QJXA",
                          returnPeriod=10,
                          waterType="high")
CARD$P2.timeStep = "none"
