var = "fA01"
type = "sévérité"
unit = "jour.an^{-1}"
glose = "Fréquence annuelle de dépassement (Q > Q01)"
event = "Crue"

NAyear_lim = 10
NApct_lim = 3

functY = compute_fAp
functY_args = list(lowLim='*threshold*')
samplePeriodY = "09-01"

functYT_sum = compute_Qp
functYT_sum_args = list(p=0.01)
