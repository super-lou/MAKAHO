CARD$P.var = paste0("dtR20mm_", gsub("[.]", "", gsub("û", "u", gsub("é", "e", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%b")))))
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = paste0("Nombre de jours de forte pluie de chaque ",
                      format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%B"),
                      " (nombre de jours avec au moins 20 mm de précipitations)")
CARD$P.topic = c("Précipitations", "Forte")
    
CARD$P1.funct = list(dtR20mm=apply_threshold)
CARD$P1.funct_args = list("R", lim=20,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
