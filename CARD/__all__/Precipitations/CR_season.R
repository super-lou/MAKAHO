CARD$P.var = c("CR_DJF", "CR_MAM", "CR_JJA", "CR_SON")
CARD$P.unit = "sans unité"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = "#543005 #8C510A #BF812D #DFC27D #F6E8C3 #C7EAE5 #80CDC1 #35978F #01665E #003C30"
CARD$P.glose = c("Coefficient correctif des précipitations hivernales", "Coefficient correctif des précipitations printanières",
                 "Coefficient correctif des précipitations estivales", "Coefficient correctif des précipitations automnales")
CARD$P.topic = c("Précipitations", "Modérée")

CARD$P1.funct = list(RA_obs=sumNA,
                     RA_sim=sumNA)
CARD$P1.funct_args = list(list("R_obs", na.rm=TRUE),
                          list("R_sim", na.rm=TRUE))
CARD$P1.timeStep = "year-season"
CARD$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.compress = TRUE

CARD$P2.funct = list(moyRA_obs_DJF=mean,
                     moyRA_obs_MAM=mean,
                     moyRA_obs_JJA=mean,
                     moyRA_obs_SON=mean,

                     moyRA_sim_DJF=mean,
                     moyRA_sim_MAM=mean,
                     moyRA_sim_JJA=mean,
                     moyRA_sim_SON=mean)
CARD$P2.funct_args = list(list("RA_obs_DJF", na.rm=TRUE),
                          list("RA_obs_MAM", na.rm=TRUE),
                          list("RA_obs_JJA", na.rm=TRUE),
                          list("RA_obs_SON", na.rm=TRUE),

                          list("RA_sim_DJF", na.rm=TRUE),
                          list("RA_sim_MAM", na.rm=TRUE),
                          list("RA_sim_JJA", na.rm=TRUE),
                          list("RA_sim_SON", na.rm=TRUE))
CARD$P2.timeStep = "none"

CARD$P3.funct = list(CR_DJF=divided,
                     CR_MAM=divided,
                     CR_JJA=divided,
                     CR_SON=divided)
CARD$P3.funct_args = list(list("moyRA_sim_DJF", "moyRA_obs_DJF"),
                          list("moyRA_sim_MAM", "moyRA_obs_MAM"),
                          list("moyRA_sim_JJA", "moyRA_obs_JJA"),
                          list("moyRA_sim_SON", "moyRA_obs_SON"))
CARD$P3.timeStep = "none"
