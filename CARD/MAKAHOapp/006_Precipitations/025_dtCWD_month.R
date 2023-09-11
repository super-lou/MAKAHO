CARD$P.var = paste0("dtCWD_", gsub("[.]", "", gsub("û", "u", gsub("é", "e", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%b")))))
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = paste0("Nombre maximal de jours consécutifs avec au moins de 1 mm de précipitation de chaque ",
                      format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%B"))
CARD$P.topic = c("Précipitations", "Période sèche")
    
CARD$P1.funct = list(dtCWD=apply_threshold)
CARD$P1.funct_args = list("P", lim=1,
                          where=">=",
                          what="length",
                          select="longest")
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
