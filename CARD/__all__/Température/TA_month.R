CARD$P.var = paste0("TA_", gsub("[.]", "", gsub("û", "u", gsub("é", "e", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%b")))))
CARD$P.unit = "°C"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#67001F #B2182B #D6604D #F4A582 #FDDBC7 #D1E5F0 #92C5DE #4393C3 #2166AC #053061"
CARD$P.glose = paste0("Moyenne des températures journalières de chaque ", format(seq.Date(as.Date("1970-01-01"), as.Date("1970-12-01"), "month"), "%B"))
CARD$P.topic = c("Température", "Moyenne")
    
CARD$P1.funct = list(TA=mean)
CARD$P1.funct_args = list("T", na.rm=TRUE)
CARD$P1.timeStep = "year-month"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE
