CARD$P.var = c("RA_DJF", "RA_MAM", "RA_JJA", "RA_SON")
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = c("Précipitations hivernales annuelles", "Précipitations printanières annuelles",
                 "Précipitations estivales annuelles", "Précipitations automnales annuelles")
CARD$P.topic = c("Précipitations", "Modérée")

CARD$P1.funct = list(RA=mean)
CARD$P1.funct_args = list("P", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
