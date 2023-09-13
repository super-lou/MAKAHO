CARD$P.var = "epsilon_P"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Élasticité annuelle du débit aux précipitations"
CARD$P.topic = c("Précipitations/Débit", "Sensibilité à la variabilité climatique")
CARD$P.samplePeriod = "Mois du minimum des débits mensuels"
    
CARD$P1.funct = list(QA=mean,
                     PA=mean)
CARD$P1.funct_args = list(list("Q", na.rm=TRUE),
                          list("P", na.rm=TRUE))
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = list(min, list("Q", na.rm=TRUE))
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("epsilon_P"=compute_elasticity)
CARD$P2.funct_args = list(Q="QA", X="PA")
CARD$P2.timeStep = "none"
CARD$P2.NApct_lim = 3
