CARD$P.var = "RA_ratio"
CARD$P.unit = ""
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Ratio des précipitation"
CARD$P.topic = c("Précipitations", "Modérée")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(RA=sumNA,
                     RAl=sumNA,
                     RAs=sumNA)
CARD$P1.funct_args = list(list("R", na.rm=TRUE),
                          list("Rl", na.rm=TRUE),
                          list("Rs", na.rm=TRUE))
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list(moyRA=mean,
                     moyRAl=mean,
                     moyRAs=mean)
CARD$P2.funct_args = list(list("RA", na.rm=TRUE),
                          list("RAl", na.rm=TRUE),
                          list("RAs", na.rm=TRUE))
CARD$P2.timeStep = "none"

CARD$P3.funct = list(Rl_ratio=divided,
                     Rs_ratio=divided)
CARD$P3.funct_args = list(list("moyRAl", "moyRA"),
                          list("moyRAs", "moyRA"))
CARD$P3.timeStep = "none"
