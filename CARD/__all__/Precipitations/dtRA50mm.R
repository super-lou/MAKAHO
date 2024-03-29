CARD$P.var = "dtRA50mm"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Nombre de jours de pluie extrème dans l'année (nombre de jours avec au moins 50 mm de précipitations)"
CARD$P.topic = c("Précipitations", "Forte")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(dtRA50mm=apply_threshold)
CARD$P1.funct_args = list("R", lim=50,
                          where=">=",
                          what="length",
                          select="all")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
