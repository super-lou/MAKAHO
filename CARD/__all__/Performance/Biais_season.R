CARD$P.var = c("Biais_DJF", "Biais_MAM", "Biais_JJA", "Biais_SON")
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = c("Différence relative entre les débits journaliers hivernaux simulés et observés",
                 "Différence relative entre les débits journaliers printaniers simulés et observés",
                 "Différence relative entre les débits journaliers estivaux simulés et observés",
                 "Différence relative entre les débits journaliers automnaux simulés et observés")
CARD$P.topic = c("Débit", "Performance", "Biais")

CARD$P1.funct = list(Biais=compute_Biais)
CARD$P1.funct_args = list("Q_obs", "Q_sim")
CARD$P1.timeStep = "season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.compress = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
