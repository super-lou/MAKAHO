CARD$P.var = c("epsilon_T_DJF", "epsilon_T_MAM",
               "epsilon_T_JJA", "epsilon_T_SON")
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = c("Élasticité hivernale du débit aux températures",
                 "Élasticité printanière du débit aux températures",
                 "Élasticité estivale du débit aux températures",
                 "Élasticité automnale du débit aux températures")
CARD$P.topic = c("Température/Débit", "Sensibilité à la variabilité climatique")
    
CARD$P1.funct = list(QA=mean,
                     TA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE),
                          list("T", na.rm=TRUE))
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

CARD$P2.funct = list("epsilon_T_DJF"=compute_elasticity,
                     "epsilon_T_MAM"=compute_elasticity,
                     "epsilon_T_JJA"=compute_elasticity,
                     "epsilon_T_SON"=compute_elasticity)
CARD$P2.funct_args = list(list(Q="QA_DJF", X="TA_DJF"),
                          list(Q="QA_MAM", X="TA_MAM"),
                          list(Q="QA_JJA", X="TA_JJA"),
                          list(Q="QA_SON", X="TA_SON"))
CARD$P2.timeStep = "none"
