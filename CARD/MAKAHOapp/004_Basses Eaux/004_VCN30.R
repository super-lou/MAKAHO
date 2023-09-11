CARD$P.var = "VCN30"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Minimum annuel de la moyenne sur 30 jours du débit journalier"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"
     
CARD$P1.funct = list(VC30=rollmean_center)
CARD$P1.funct_args = list("Q", k=30)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(VCN30=minNA)
CARD$P2.funct_args = list("VC30", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
