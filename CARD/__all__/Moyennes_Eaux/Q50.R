CARD$P.var = "Q50"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Débit seuil avec une probabilité de dépassement de 50% (centile 50%)"
CARD$P.topic = c("Débit", "Moyennes Eaux", "Liés à une statistique")

CARD$P1.funct = list(Q50=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.5)
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
