CARD$P.var = c("alphaVCN10", "HYPalphaVCN10")
CARD$P.unit = "m^{3}.s^{-1}.an^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = c(TRUE,
                     FALSE)
CARD$P.palette = NULL
CARD$P.glose = "Pente de Sen et résultat du test de Mann-Kendall pour les minimums annuel de la moyenne sur 10 jours du débit journalier"
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

CARD$P3.funct = list(alphaVCN10=get_MKalpha,
                     HYPalphaVCN10=get_MKH)
CARD$P3.funct_args = list(list("VCN10", level=0.1),
                          list("VCN10", level=0.1))
CARD$P3.timeStep = "none"
