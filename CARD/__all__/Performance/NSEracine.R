CARD$P.var = "NSEracine"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Coeffcient d'efficacité de Nash-Sutcliffe de la racine carrée des données"
CARD$P.topic = c("Débit", "Performance", "NSE")

CARD$P1.funct = list(NSEracine=compute_NSEracine)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
