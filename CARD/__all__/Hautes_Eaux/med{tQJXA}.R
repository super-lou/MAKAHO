CARD$P.var = "med{tQJXA}"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Mediane des dates maximums annuels des débits journaliers"
CARD$P.topic = c("Débit", "Hautes Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"

CARD$P1.funct = list(tQJXA=which.maxNA)
CARD$P1.funct_args = list("Q")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P1.isDate = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("med{tQJXA}"=circular_median)
CARD$P2.funct_args = list("tQJXA", periodicity=365.25, na.rm=TRUE)
CARD$P2.timeStep = "none"
