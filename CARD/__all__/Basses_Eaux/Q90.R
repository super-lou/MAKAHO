CARD$P.var = "Q90"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Débit seuil avec une probabilité de dépassement de 90% (centile 10%)"
CARD$P.topic = c("Débit", "Basses Eaux", "Liés à une statistique")

CARD$P1.funct = list(Q90=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.9)
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
