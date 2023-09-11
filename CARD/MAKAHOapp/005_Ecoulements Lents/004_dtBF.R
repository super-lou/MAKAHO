CARD$P.var = "dtBF"
CARD$P.unit = "jour"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.reverse_palette = TRUE
CARD$P.glose = "Durée des écoulements lents, durée entre le début et la fin des écoulements lents"
CARD$P.topic = c("Débit", "Écoulements Lents")
CARD$P.samplePeriod = '09-01'

CARD$P1.funct = list(dtBF=compute_tSnowmelt)
CARD$P1.funct_args = list("Q", p1=0.1, p2=0.9)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
