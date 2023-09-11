CARD$P.var = "QA90"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.reverse_palette = FALSE
CARD$P.glose = "Débit seuil annuel avec une probabilité de dépassement de 90% (centile 10%)"
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = "01-01"
    
CARD$P1.funct = list(QA90=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.9)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "01-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
