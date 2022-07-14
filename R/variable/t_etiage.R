var = "t_etiage"
type = "saisonnalité"
unit = "jour"
glose = "Durée de l'étiage (durée de la plus longue période continue de la moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = 10

functM = NULL
functM_args = NULL
isDateM = FALSE


length_under = function (L, UpLim, select_longest=TRUE) {
    
    ID = which(L <= UpLim)

    if (select_longest) {
        dID = diff(ID)
        dID = c(10, dID)
        
        IDjump = which(dID != 1)
        Njump = length(IDjump)
        
        Periods = vector(mode='list', length=Njump)
        Nperiod = c()
        
        for (i in 1:Njump) {
            idStart = IDjump[i]
            
            if (i < Njump) {
                idEnd = IDjump[i+1] - 1
            } else {
                idEnd = length(ID)
            }
            
            period = ID[idStart:idEnd]
            Periods[[i]] = period
            Nperiod = c(Nperiod, length(period))
        }
        period_max = Periods[[which.max(Nperiod)]]
        len = period_max[length(period_max)] - period_max[1] + 1
    } else {
        len = ID[length(ID)] - ID[1] + 1
    }
    return (len)
}


functY = length_under
functY_args = list(select_longest=TRUE,
                   UpLim='*threshold*')
isDateY = FALSE

minNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (min(X))
    }
}

maxNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (max(X))
    }
}

functYT_ext = minNA
functYT_ext_args = list(na.rm=TRUE)
isDateYT_ext = FALSE
functYT_sum = maxNA
functYT_sum_args = list(na.rm=TRUE)
