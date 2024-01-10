CARD$P.var = "debutBF"
CARD$P.unit = "jour de l'année"
CARD$P.is_date = TRUE
CARD$P.normalize = FALSE
CARD$P.palette = "#893687 #BC66A5 #E596C3 #EAC5DD #EFE2E9 #F5E4E2 #F2D7B5 #E9BD6F #DC8C48 #CD5629"
CARD$P.glose = "Début des écoulements lents, date à laquelle 10% de l’intégrale sous la courbe du débit de base est atteinte"
CARD$P.topic = c("Débit", "Écoulements Lents")
CARD$P.samplePeriod = '09-01'
    
CARD$P1.funct = list(debutBF=compute_tVolSnowmelt)
CARD$P1.funct_args = list("Q", p=0.1)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.isDate = TRUE
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
