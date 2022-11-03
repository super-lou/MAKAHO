var = "QMNA"
type = "sévérité"
unit = "m^{3}.s^{-1}"
glose = "Minimum annuel de la moyenne mensuelle du débit journalier"
event = "Étiage"

NAyear_lim = 10
NApct_lim = 3

functM = mean
functM_args = list(na.rm=TRUE)
hydroPeriodM = NULL

functY = minNA
functY_args = list(na.rm=TRUE)
hydroPeriodY = c('05-01', '11-30')
