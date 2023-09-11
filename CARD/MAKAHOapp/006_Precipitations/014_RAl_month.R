CARD$P.var = paste0("RAl_", gsub("[.]", "", gsub("û", "u", gsub("é", "e", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%b")))))
CARD$P.unit = "mm"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = paste0("Moyenne des précipitations liquides journalières de chaque ",
                      format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%B"))
CARD$P.topic = c("Précipitations", "Modérée")
    
CARD$P1.funct = list(RAl=mean)
CARD$P1.funct_args = list("Pl", na.rm=TRUE)
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
