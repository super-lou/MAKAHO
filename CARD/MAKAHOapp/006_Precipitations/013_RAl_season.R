CARD$P.var = c("RAl_DJF", "RAl_MAM", "RAl_JJA", "RAl_SON")
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = c("Précipitations liquides hivernales annuelles", "Précipitations liquides printanières annuelles",
                 "Précipitations liquides estivales annuelles", "Précipitations liquides automnales annuelles")
CARD$P.topic = c("Précipitations", "Modérée")

CARD$P1.funct = list(RAl=mean)
CARD$P1.funct_args = list("Pl", na.rm=TRUE)
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
