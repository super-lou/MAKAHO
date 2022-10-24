var = "tFIN_etiage"
type = "saisonnalité"
unit = "jour de l'année"
glose = "Fin d'étiage (jour de l'année de la dernière moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

NAyear_lim = 10
NApct_lim = 3
day_to_roll = 10

functM = NULL
functM_args = NULL
isDateM = FALSE

functY = under_threshold
functY_args = list(what="last",
                   select_longest=TRUE,
                   UpLim='*threshold*')
isDateY = TRUE

functYT_ext = minNA
functYT_ext_args = list(na.rm=TRUE)
isDateYT_ext = FALSE
functYT_sum = maxNA
functYT_sum_args = list(na.rm=TRUE)
