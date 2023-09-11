CARD$P.var = "QA10"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.reverse_palette = TRUE
CARD$P.glose = "Débit seuil annuel avec une probabilité de dépassement de 10% (centile 90%)"
CARD$P.topic = c("Débit", "Hautes Eaux")
CARD$P.samplePeriod = "01-01"
    
CARD$P1.funct = list(QA10=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.1)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "01-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
