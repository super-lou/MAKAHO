var = "vDEF_etiage"
type = "Volume"
unit = "hm^{3}"
glose = "Volume de déficite de l'étiage (intégrale de la courbe de la moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = 10

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = compute_VolDef
functY_args = list(select_longest=TRUE,
                   UpLim='*threshold*')
isDateY = FALSE

functYT_ext = minNA
functYT_ext_args = list(na.rm=TRUE)
isDateYT_ext = FALSE
functYT_sum = maxNA
functYT_sum_args = list(na.rm=TRUE)
