CARD$P.var = "dtCrue"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.reverse_palette = TRUE
CARD$P.glose = "Nombres de jour où la différence entre le débit journalier et le débit de base est supérieur à la moitié du maximum annuel"
CARD$P.topic = c("Débit", "Hautes Eaux", "Signature hydrologique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"
    
CARD$P1.funct = list(dQ=dBFS)
CARD$P1.funct_args = list("Q")
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(dQXA=maxNA)
CARD$P2.funct_args = list("dQ", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P2.keep = "all"

CARD$P3.funct = list(lowLim=divided)
CARD$P3.funct_args = list("dQXA", 2, first=TRUE)
CARD$P3.timeStep = "year"
CARD$P3.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P3.keep = "all"

CARD$P4.funct = list(dtCrue=apply_threshold)
CARD$P4.funct_args = list("dQ",
                          lim="lowLim",
                          where=">=",
                          what="length",
                          select="dQXA")
CARD$P4.timeStep = "year"
CARD$P4.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P4.NApct_lim = 3
