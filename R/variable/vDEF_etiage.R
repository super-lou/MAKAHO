var = "vDEF_etiage"
type = "Volume"
unit = "m^{3}"
glose = "Volume de déficite de l'étiage (intégrale de la courbe de la moyenne sur 10 jours sous le maximum des VCN10)"
event = "Étiage"
hydroPeriod = c('05-01', '11-30')

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = 10

functM = NULL
functM_args = NULL
isDateM = FALSE


compute_VolDef = function (X, UpLim, select_longest=TRUE) {
    Xdef = X_under(X, UpLim=UpLim, select_longest=select_longest)
    Vol = cumsum(Xdef)*24*3600 # m^3.s-1 * jour
    return (Vol)
}

X_under = function (X, UpLim, select_longest=TRUE) {
    
    ID = which(X <= UpLim)

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
        per = period_max
    } else {
        per = ID
    }
    Xper = X[per]
    return (Xper)
}


functY = compute_VolDef
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
