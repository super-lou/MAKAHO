CARD$P.var = "dtRA01mm"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Nombre de jours pluvieux dans l'année (nombre de jours avec au moins 1 mm de précipitations)"
CARD$P.topic = c("Précipitations", "Faible")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(dtRA01mm=apply_threshold)
CARD$P1.funct_args = list("P", lim=1,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
