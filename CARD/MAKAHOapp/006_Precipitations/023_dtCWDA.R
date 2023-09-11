CARD$P.var = "dtCWDA"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Nombre maximal de jours consécutifs dans l'année avec au moins 1 mm de précipitation"
CARD$P.topic = c("Précipitations", "Faibles")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(dtCWDA=apply_threshold)
CARD$P1.funct_args = list("P", lim=1,
                          where=">=",
                          what="length",
                          select="longest")
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
