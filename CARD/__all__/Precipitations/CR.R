CARD$P.var = "CR"
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = "Coefficient correctif des précipitations"
CARD$P.topic = c("Précipitations", "Modérée")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(RA_obs=sumNA,
                     RA_sim=sumNA)
CARD$P1.funct_args = list(list("R_obs", na.rm=TRUE),
                          list("R_sim", na.rm=TRUE))
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(moyRA_obs=mean,
                     moyRA_sim=mean)
CARD$P2.funct_args = list(list("RA_obs", na.rm=TRUE),
                          list("RA_sim", na.rm=TRUE))
CARD$P2.timeStep = "none"

CARD$P3.funct = list(CR=divided)
CARD$P3.funct_args = list("moyRA_sim", "moyRA_obs")
CARD$P3.timeStep = "none"
