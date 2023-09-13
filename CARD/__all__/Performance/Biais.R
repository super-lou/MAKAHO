CARD$P.var = "Biais"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Différence relative entre les débits journaliers simulés et observés"
CARD$P.topic = c("Débit", "Performance", "Biais")

CARD$P1.funct = list(Biais=compute_Biais)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.timeStep = "none"
CARD$P1.NAyear_lim = 10
