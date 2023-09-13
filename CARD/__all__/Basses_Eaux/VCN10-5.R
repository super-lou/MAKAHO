CARD$P.var = "VCN10-5"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Minimum annuel de la moyenne sur 10 jours du débit journalier de période de retour 5 ans"
CARD$P.topic = c("Débit", "Basses Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"
    
CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3

CARD$P3.funct = list("VCN10-5"=get_Xn)
CARD$P3.funct_args = list("VCN10",
                          returnPeriod=5,
                          waterType="low")
CARD$P3.timeStep = "none"
