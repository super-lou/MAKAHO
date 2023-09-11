CARD$P.var = c("TA_DJF", "TA_MAM", "TA_JJA", "TA_SON")
CARD$P.unit = "°C"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = TRUE
CARD$P.glose = c("Température hivernales annuelle", "Température printanières annuelle",
                 "Température estivales annuelle", "Température automnales annuelle")
CARD$P.topic = c("Température", "Moyenne")

CARD$P1.funct = list(TA=mean)
CARD$P1.funct_args = list("T", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
