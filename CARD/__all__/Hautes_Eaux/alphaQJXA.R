CARD$P.var = c("alphaQJXA", "HYPalphaQJXA")
CARD$P.unit = "m^{3}.s^{-1}.an^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = c(TRUE,
                     FALSE)
CARD$P.palette = NULL
CARD$P.glose = "Pente de Sen et résultat du test de Mann-Kendall pour les maximums annuels des débits journaliers"
CARD$P.topic = c("Débit", "Hautes Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"
    
CARD$P1.funct = list(QJXA=maxNA)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(alphaQJXA=get_MKalpha,
                     HYPalphaQJXA=get_MKH)
CARD$P2.funct_args = list(list("QJXA", level=0.1),
                          list("QJXA", level=0.1))
CARD$P2.timeStep = "none"
