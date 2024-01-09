CARD$P.var = c("med{debutBE}",
               "med{finBE}",
               "med{dtBE}",
               "med{vBE}")
CARD$P.unit = c("jour de l'année",
                "jour de l'année",
                "jour",
                "hm^{3}")
CARD$P.is_date = c(TRUE,
                   TRUE,
                   FALSE,
                   FALSE)
CARD$P.normalize = c(FALSE,
                     FALSE,
                     FALSE,
                     TRUE)
CARD$P.palette = NULL
CARD$P.glose = c("Médiane du début des basses eaux, date de la première moyenne sur 10 jours sous le maximum des minimums annuels de la moyenne sur 10 jours du débit journalier",
                 "Médiane de la fin des basses eaux, date de la dernière moyenne sur 10 jours sous le maximum des minimums annuels de la moyenne sur 10 jours du débit journalier",
                 "Médiane de la durée des basses eaux, durée de la plus longue période continue de la moyenne sur 10 jours sous le maximum des VCN10",
                 "Médiane du volume de déficite des basses eaux, intégrale de la courbe de la moyenne sur 10 jours sous le maximum des VCN10")
CARD$P.topic = c("Débit", "Basses Eaux")
CARD$P.samplePeriod = "Mois du maximum des débits mensuels"

CARD$P1.funct = list(VC10=rollmean_center)
CARD$P1.funct_args = list("Q", k=10)
CARD$P1.timeStep = "none"
CARD$P1.keep = "all"

CARD$P2.funct = list(VCN10=minNA)
CARD$P2.funct_args = list("VC10", na.rm=TRUE)
CARD$P2.timeStep = "year"
CARD$P2.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P2.NApct_lim = 3
CARD$P2.NAyear_lim = 10
CARD$P2.keep = "all"

CARD$P3.funct = list(upLim=maxNA)
CARD$P3.funct_args = list("VCN10", na.rm=TRUE)
CARD$P3.timeStep = "none"
CARD$P3.keep = "all"

CARD$P4.funct = list(debutBE=apply_threshold,
                     finBE=apply_threshold,
                     dtBE=apply_threshold,
                     vBE=compute_VolDef)
CARD$P4.funct_args = list(list("VC10",
                               lim="upLim",
                               where="<=",
                               what="first",
                               select="longest"),
                          list("VC10",
                               lim="upLim",
                               where="<=",
                               what="last",
                               select="longest"),
                          list("VC10",
                               lim="upLim",
                               where="<=",
                               what="length",
                               select="longest"),
                          list("VC10",
                               select="longest",
                               upLim="upLim"))
CARD$P4.timeStep = "year"
CARD$P4.samplePeriod = list(max, list("Q", na.rm=TRUE))
CARD$P4.isDate = c(TRUE,
                   TRUE,
                   FALSE,
                   FALSE)
CARD$P4.NApct_lim = 3

CARD$P5.funct = list("med{debutBE}"=circular_median,
                     "med{finBE}"=circular_median,
                     "med{dtBE}"=median,
                     "med{vBE}"=median)
CARD$P5.funct_args = list(list("debutBE", periodicity=365.25, na.rm=TRUE),
                          list("finBE", periodicity=365.25, na.rm=TRUE),
                          list("dtBE", na.rm=TRUE),
                          list("vBE", na.rm=TRUE))
CARD$P5.timeStep = "none"
CARD$P5.compress = TRUE
