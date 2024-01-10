CARD$P.var = c("dtR01mm_DJF", "dtR01mm_MAM", "dtR01mm_JJA", "dtR01mm_SON")
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Nombre de jours pluvieux en hiver (nombre de jours avec au moins 1 mm de précipitations)",
                 "Nombre de jours pluvieux au printemps (nombre de jours avec au moins 1 mm de précipitations)",
                 "Nombre de jours pluvieux en été (nombre de jours avec au moins 1 mm de précipitations)",
                 "Nombre de jours pluvieux en automne (nombre de jours avec au moins 1 mm de précipitations)")
CARD$P.topic = c("Précipitations", "Faible")

CARD$P1.funct = list(dtR01mm=apply_threshold)
CARD$P1.funct_args = list("R", lim=1,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
