CARD$P.var = "TA"
CARD$P.unit = "°C"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = TRUE
CARD$P.glose = "Température moyenne annuelle"
CARD$P.topic = c("Température", "Moyenne")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(TA=mean)
CARD$P1.funct_args = list("T", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
