var = "vDEF_etiage"
type = "Volume"
unit = "hm^{3}"
glose = "Volume de déficite de l'étiage (intégrale de la courbe de la moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"

NAyear_lim = 10
NApct_lim = 3
day_to_roll = 10

functY = compute_VolDef
functY_args = list(select_longest=TRUE,
                   UpLim='*threshold*')
samplePeriodY = c('05-01', '11-30')

functYT_ext = minNA
functYT_ext_args = list(na.rm=TRUE)
functYT_sum = maxNA
functYT_sum_args = list(na.rm=TRUE)
