CARD$P.var = c("dtR50mm_DJF", "dtR50mm_MAM", "dtR50mm_JJA", "dtR50mm_SON")
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Nombre de jours de pluie extrème en hiver (nombre de jours avec au moins 50 mm de précipitations)",
                 "Nombre de jours de pluie extrème au printemps (nombre de jours avec au moins 50 mm de précipitations)",
                 "Nombre de jours de pluie extrème en été (nombre de jours avec au moins 50 mm de précipitations)",
                 "Nombre de jours de pluie extrème en automne (nombre de jours avec au moins 50 mm de précipitations)")
CARD$P.topic = c("Précipitations", "Forte")

CARD$P1.funct = list(dtR50mm=apply_threshold)
CARD$P1.funct_args = list("R", lim=50,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
