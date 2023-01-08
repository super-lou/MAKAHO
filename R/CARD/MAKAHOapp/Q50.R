CARD$P.var = "Q50"
CARD$P.unit = "m^{3}.s^{-1}"
CARD$P.glose = "Débit seuil avec une probabilité de dépassement de 50% (centile 50%)"
CARD$P.topic = "Moyennes Eaux"
CARD$P.samplePeriod = '09-01'
    
CARD$P1.funct = list(X=compute_Qp)
CARD$P1.funct_args = list("Q", p=0.5)
CARD$P1.timeStep = "year"
CARD$P1.samplePeriod = '09-01'
CARD$P1.NApct_lim = 3
CARD$P1.NAyear_lim = 10
CARD$P1.rmNApct = FALSE
