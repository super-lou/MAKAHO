CARD$P.var = c("deltaQA_{2040-2069}", "deltaQA_{2070-2099}")
CARD$P.unit = "m^{3}.s^{-1}.an^{-1}"
CARD$P.is_date = FALSE
CARD$P.normalize = FALSE
CARD$P.palette = NULL
CARD$P.glose = "Différence relative des moyennes annuelles des débits journaliers entre une période futur et une période passée de référence."
CARD$P.topic = c("Débit", "Moyennes Eaux", "Projection")
CARD$P.samplePeriod = "09-01"

CARD$P2.funct = list("deltaQA_{2040-2069}"=deltaX,
                     "deltaQA_{2070-2099}"=deltaX)
CARD$P2.funct_args = list(list("QA",
                               "Date",
                               past=c("1976-01-01", "2005-12-31"),
                               futur=c("2040-01-01", "2069-12-31")),
                          list("QA",
                               "Date",
                               past=c("1976-01-01", "2005-12-31"),
                               futur=c("2070-01-01", "2099-12-31")))
CARD$P2.timeStep = "none"
