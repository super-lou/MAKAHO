CARD$P.var = "moyQA"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = TRUE
CARD$P.palette = NULL
CARD$P.glose = "Moyenne inter-annuelle des moyennes intra-annuelles des débits journaliers"
CARD$P.topic = c("Débit", "Moyennes Eaux", "Liés à une statistique")
CARD$P.samplePeriod = "09-01"

CARD$P1.funct = list(QA=mean)
CARD$P1.funct_args = list("Q", na.rm=TRUE)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = "09-01"
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10

CARD$P2.funct = list("moyQA"=mean)
CARD$P2.funct_args = list("QA", na.rm=TRUE)
CARD$P2.timeStep = "none"
