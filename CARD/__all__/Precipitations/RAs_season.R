CARD$P.var = c("RAs_DJF", "RAs_MAM", "RAs_JJA", "RAs_SON")
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Précipitations solides hivernales annuelles", "Précipitations solides printanières annuelles",
                 "Précipitations solides estivales annuelles", "Précipitations solides automnales annuelles")
CARD$P.topic = c("Précipitations", "Modérée")

CARD$P1.funct = list(RAs=mean)
CARD$P1.funct_args = list("Ps", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
