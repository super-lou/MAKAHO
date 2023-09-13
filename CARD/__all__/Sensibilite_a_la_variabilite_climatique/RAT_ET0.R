CARD$P.var = "RAT_ET0"
CARD$P.unit = "bool"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Test de robustesse à une variation d'évapotranspiration de référence"
CARD$P.topic = c("Évapotranspiration/Débit", "Sensibilité à la variabilité climatique")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(BiaisA=compute_Biais,
                     ET0A=mean)
CARD$P1.funct_args = list(list("Q_obs", "Q_sim"),
                          list("ET0_obs", na.rm=TRUE))
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(RAT_ET0=compute_RAT_X)
CARD$P2.funct_args = list("BiaisA", "ET0A", thresh=0.05)
CARD$P2.timeStep = "none"
