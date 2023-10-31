CARD$P.var = c("moyTA_DJF", "moyTA_MAM", "moyTA_JJA", "moyTA_SON")
CARD$P.unit = "°C"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#053061 #2166AC #4393C3 #92C5DE #D1E5F0 #FDDBC7 #F4A582 #D6604D #B2182B #67001F"
CARD$P.glose = c("Moyennes des températures hivernales annuelles", "Moyennes des températures printanières annuelles",
                 "Moyennes des température estivales annuelles", "Moyennes des températures automnales annuelles")
CARD$P.topic = c("Température", "Moyenne")

CARD$P1.funct = list(TA=mean)
CARD$P1.funct_args = list("T", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

CARD$P2.funct = list(moyTA_DJF=mean,
                     moyTA_MAM=mean,
                     moyTA_JJA=mean,
                     moyTA_SON=mean)
CARD$P2.funct_args = list(list("TA_DJF", na.rm=TRUE),
                          list("TA_MAM", na.rm=TRUE),
                          list("TA_JJA", na.rm=TRUE),
                          list("TA_SON", na.rm=TRUE))
CARD$P2.timeStep = "none"
