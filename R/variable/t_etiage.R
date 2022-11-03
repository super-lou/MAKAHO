var = "t_etiage"
type = "saisonnalité"
unit = "jour"
glose = "Durée de l'étiage (durée de la plus longue période continue de la moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"

NAyear_lim = 10
NApct_lim = 3
day_to_roll = 10

functY = under_threshold
functY_args = list(what="length",
                   select_longest=TRUE,
                   UpLim='*threshold*')
samplePeriodY = c('05-01', '11-30')

functYT_ext = minNA
functYT_ext_args = list(na.rm=TRUE)
functYT_sum = maxNA
functYT_sum_args = list(na.rm=TRUE)
