CARD$P.var = c("moyRA_DJF", "moyRA_MAM", "moyRA_JJA", "moyRA_SON")
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Moyenne des précipitations hivernales annuelles", "Moyenne des précipitations printanières annuelles",
                 "Moyenne des précipitations estivales annuelles", "Moyenne des précipitations automnales annuelles")
CARD$P.topic = c("Précipitations", "Modérée")

CARD$P1.funct = list(RA=sumNA)
CARD$P1.funct_args = list("R", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

CARD$P2.funct = list(moyRA_DJF=mean,
                     moyRA_MAM=mean,
                     moyRA_JJA=mean,
                     moyRA_SON=mean)
CARD$P2.funct_args = list(list("RA_DJF", na.rm=TRUE),
                          list("RA_MAM", na.rm=TRUE),
                          list("RA_JJA", na.rm=TRUE),
                          list("RA_SON", na.rm=TRUE))
CARD$P2.timeStep = "none"
