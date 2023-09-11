CARD$P.var = c("dtR20mm_DJF", "dtR20mm_MAM", "dtR20mm_JJA", "dtR20mm_SON")
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = c("Nombre de jours de forte pluie en hiver (nombre de jours avec au moins 20 mm de précipitations)",
                 "Nombre de jours de forte pluie au printemps (nombre de jours avec au moins 20 mm de précipitations)",
                 "Nombre de jours de forte pluie en été (nombre de jours avec au moins 20 mm de précipitations)",
                 "Nombre de jours de forte pluie en automne (nombre de jours avec au moins 20 mm de précipitations)")
CARD$P.topic = c("Précipitations", "Forte")

CARD$P1.funct = list(dtR20mm=apply_threshold)
CARD$P1.funct_args = list("P", lim=20,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
