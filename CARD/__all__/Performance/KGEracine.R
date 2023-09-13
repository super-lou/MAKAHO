CARD$P.var = "KGEracine"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Coeffcient d'efficacité de Kling-Gupta de la racine carrée des données"
CARD$P.topic = c("Débit", "Performance", "KGE")

CARD$P1.funct = list(KGEracine=compute_KGEracine)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
