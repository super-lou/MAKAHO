CARD$P.var = "QA05"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Débit seuil annuel avec une probabilité de dépassement de 5% (centile 95%)"
CARD$P.topic = c("Débit", "Hautes Eaux")
CARD$P.samplePeriod = "01-01"
    
CARD$P1.funct = list(QA05=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.05)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "01-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
