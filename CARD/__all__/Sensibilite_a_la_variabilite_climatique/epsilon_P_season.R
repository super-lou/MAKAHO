CARD$P.var = c("epsilon_P_DJF", "epsilon_P_MAM",
               "epsilon_P_JJA", "epsilon_P_SON")
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = c("Élasticité hivernale du débit aux précipitations",
                 "Élasticité printanière du débit aux précipitations",
                 "Élasticité estivale du débit aux précipitations",
                 "Élasticité automnale du débit aux précipitations")
CARD$P.topic = c("Précipitations/Débit", "Sensibilité à la variabilité climatique")
    
CARD$P1.funct = list(QA=mean,
                     PA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE),
                          list("P", na.rm=TRUE))
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.onlyDate4Season = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("epsilon_P"=compute_elasticity)
CARD$P2.funct_args = list(Q="QA", X="PA")
CARD$P2.timeStep = "season"
CARD$P2.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P2.compress = TRUE
CARD$P2.NApct_lim = 3
