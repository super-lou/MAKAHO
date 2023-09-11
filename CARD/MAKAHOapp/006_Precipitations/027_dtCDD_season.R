CARD$P.var = c("dtCDD_DJF", "dtCDD_MAM", "dtCDD_JJA", "dtCDD_SON")
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = TRUE
CARD$P.glose = c("Nombre maximal de jours consécutifs dans l'hiver avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs au printemps avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs en été avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs en automne avec moins de 1 mm de précipitation")
CARD$P.topic = c("Précipitations", "Période sèche")

CARD$P1.funct = list(dtCDD=apply_threshold)
CARD$P1.funct_args = list("P", lim=1,
                          where="<",
                          what="length",
                          select="longest")
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
