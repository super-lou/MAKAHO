CARD$P.var = c("epsilon_R_DJF", "epsilon_R_MAM",
               "epsilon_R_JJA", "epsilon_R_SON")
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
                     RA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE),
                          list("R", na.rm=TRUE))
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

CARD$P2.funct = list("epsilon_R_DJF"=compute_elasticity,
                     "epsilon_R_MAM"=compute_elasticity,
                     "epsilon_R_JJA"=compute_elasticity,
                     "epsilon_R_SON"=compute_elasticity)
CARD$P2.funct_args = list(list(Q="QA_DJF", X="RA_DJF"),
                          list(Q="QA_MAM", X="RA_MAM"),
                          list(Q="QA_JJA", X="RA_JJA"),
                          list(Q="QA_SON", X="RA_SON"))
CARD$P2.timeStep = "none"
