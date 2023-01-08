CARD$P.var = "Q90"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.glose = "Débit seuil avec une probabilité de dépassement de 90% (centile 10%)"
CARD$P.topic = "Moyennes Eaux"
CARD$P.samplePeriod = '09-01'
    
CARD$P1.funct = list(X=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.9)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.rmNApct = FALSE
