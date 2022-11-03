var = "VCN10"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Minimum annuel de la moyenne sur 10 jours du débit journalier"
event = "Étiage"

NAyear_lim = 10
NApct_lim = 3
day_to_roll = 10

functY = minNA
functY_args = list(na.rm=TRUE)
samplePeriodY = c('05-01', '11-30')
