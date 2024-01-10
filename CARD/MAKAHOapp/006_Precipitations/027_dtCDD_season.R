CARD$P.var = c("dtCDD_DJF", "dtCDD_MAM", "dtCDD_JJA", "dtCDD_SON")
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005"
CARD$P.glose = c("Nombre maximal de jours consécutifs dans l'hiver avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs au printemps avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs en été avec moins de 1 mm de précipitation",
                 "Nombre maximal de jours consécutifs en automne avec moins de 1 mm de précipitation")
CARD$P.topic = c("Précipitations", "Période sèche")

CARD$P1.funct = list(dtCDD=apply_threshold)
CARD$P1.funct_args = list("R", lim=1,
                          where="<",
                          what="length",
                          select="longest")
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
