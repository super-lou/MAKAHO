CARD$P.var = "dtRA20mm"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Nombre de jours de forte pluie dans l'année (nombre de jours avec au moins 20 mm de précipitations)"
CARD$P.topic = c("Précipitations", "Forte")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(dtRA20mm=apply_threshold)
CARD$P1.funct_args = list("P", lim=20,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
