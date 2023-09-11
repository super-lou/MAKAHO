CARD$P.var = "tQJXA"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = TRUE
CARD$P.glose = "Date du maximum annuel du débit journalier"
CARD$P.topic = c("Débit", "Hautes Eaux")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"

CARD$P1.funct = list(tQJXA=which.maxNA)
CARD$P1.funct_args = list("Q")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P1.isDate = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
