CARD$P.var = paste0("dtCDD_", gsub("[.]", "", gsub("û", "u", gsub("é", "e", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%b")))))
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#003C30 #01665E #35978F #80CDC1 #C7EAE5 #F6E8C3 #DFC27D #BF812D #8C510A #543005"
CARD$P.glose = paste0("Nombre maximal de jours consécutifs avec moins de 1 mm de précipitation de chaque ",
                      format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%B"))
CARD$P.topic = c("Précipitations", "Période sèche")
    
CARD$P1.funct = list(dtCDD=apply_threshold)
CARD$P1.funct_args = list("P", lim=1,
                          where="<",
                          what="length",
                          select="longest")
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
