#  _  _       _     ___                 _   __  _     
# | \| | ___ | |_  / __| _ __  ___  __ (_) / _|(_) __ 
# | .` |/ _ \|  _| \__ \| '_ \/ -_)/ _|| ||  _|| |/ _|
# |_|\_|\___/ \__| |___/| .__/\___|\__||_||_|  |_|\__| _______________
## 1. Volumique _______ |_| __________________________________________                           
minNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (min(X, na.rm=na.rm))
    }
}

maxNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (max(X, na.rm=na.rm))
    }
}

compute_Qp = function (Q, p) {
    Qp = quantile(Q[!is.na(Q)], p)
    return (Qp)
}

## 2. Temporelle _____________________________________________________
which.minNA = function (x) {
    idMin = which.min(x)
    if (identical(idMin, integer(0))) {
        idMin = NA
    }
    return (idMin)
}

which.maxNA = function (x) {
    idMax = which.max(x)
    if (identical(idMax, integer(0))) {
        idMax = NA
    }
    return (idMax)
}

## 3. Fréquentielle __________________________________________________
compute_fAp = function (Q, p) {
    Qp = compute_Qp(Q, p)
    n = sum(as.numeric(Q[!is.na(Q)] > Qp))
    N = length(Q)
    fA = n/N
    return (fA)
}


#  ___                  ___  _              
# | _ ) __ _  ___ ___  | __|| | ___ __ __ __
# | _ \/ _` |(_-</ -_) | _| | |/ _ \\ V  V /
# |___/\__,_|/__/\___| |_|  |_|\___/ \_/\_/  _________________________
## 1. Base Flow Separation ___________________________________________
BFS = function (Q, d=5, w=0.9) {

    N = length(Q)
    if (all(is.na(Q))) {
        return (NA)
    }
    Slices = split(Q, ceiling(seq_along(Q)/d))    
    idMinSlices = unlist(lapply(Slices, which.minNA),
                         use.names=FALSE)
    
    idShift = c(0, cumsum(unlist(lapply(Slices, length),
                                 use.names=FALSE)))
    idShift = idShift[-length(idShift)]
    idMin = idMinSlices + idShift
    Qmin_k = Q[idMin]

    if (length(Qmin_k) == 1) {
        BF = rep(NA, N)
        return (BF)
    }

    n = length(Qmin_k)
    Qmin_kp1 = c(Qmin_k[2:n], NA)
    Qmin_km1 = c(NA, Qmin_k[1:(n-1)])
    test = w * Qmin_k < pmin(Qmin_km1, Qmin_kp1)
    test[is.na(test)] = FALSE
    idPivots = idMin[which(test)]
    Pivots = Qmin_k[test]

    nbNAid = length(idPivots[!is.na(idPivots)])
    nbNA = length(Pivots[!is.na(Pivots)])
    if (nbNAid >= 2 & nbNA >= 2) {
        BF = Hmisc::approxExtrap(idPivots, Pivots, xout=1:N,
                          method="linear", na.rm=TRUE)$y  
        BF[is.na(Q)] = NA
        BF[BF < 0] = 0
        test = BF > Q
        test[is.na(test)] = FALSE
        BF[test] = Q[test]
        
    } else {
        BF = rep(NA, N)
    }    
    return (BF)
}

## 2. Volumique ______________________________________________________
compute_VolSnowmelt = function (X) {
    BF = BFS(X)
    VolSnowmelt = sum(BF)*24*3600 # m^3.s-1 * jour
    return (VolSnowmelt)
}

## 3. Temporelle _____________________________________________________
compute_tVolSnowmelt = function (X, p) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt / maxNA(VolSnowmelt, na.rm=TRUE)
    idp = which.minNA(abs(pVolSnowmelt - p))
    return (idp)
}

compute_tSnowmelt = function (X, p1, p2) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt / maxNA(VolSnowmelt, na.rm=TRUE)
    idp1 = which.minNA(abs(pVolSnowmelt - p1))
    idp2 = which.minNA(abs(pVolSnowmelt - p2))
    len = idp2 - idp1 + 1
    return (len)
}


#  _____  _                   _          _     _ 
# |_   _|| |_   _ _  ___  ___| |_   ___ | | __| |
#   | |  | ' \ | '_|/ -_)(_-<| ' \ / _ \| |/ _` |
#   |_|  |_||_||_|  \___|/__/|_||_|\___/|_|\__,_| ____________________
## 1. 
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

which_underfirst = function (L, UpLim, select_longest=TRUE) {
    
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
        id = period_max[1]
    } else {
        id = ID[1]
    }
    return (id)
}

which_underlast = function (L, UpLim, select_longest=TRUE) {
    
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
        id = period_max[length(period_max)]
    } else {
        id = ID[length(ID)]
    }
    return (id)
}

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

compute_VolDef = function (X, UpLim, select_longest=TRUE) {
    Xdef = under_threshold(X, UpLim=UpLim, what="X", select_longest=select_longest)
    Vol = sum(Xdef)*24*3600 # m^3.s-1 * jour
    return (Vol)
}


under_threshold = function (X, UpLim, what="X", select_longest=TRUE) {
    
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

        if (what == "X") {
            res = X[period_max]
        } else if (what == "length") {
            res = period_max[length(period_max)] - period_max[1] + 1
        } else if (what == "last") {
            res = period_max[length(period_max)]
        } else if (what == "first") {
            res = period_max[1]
        }
        
    } else {
        if (what == "X") {
            res = X[ID]            
        } else if (what == "length") {
            res = ID[length(ID)] - ID[1] + 1
        } else if (what == "last") {
            res = ID[length(ID)]
        } else if (what == "first") {
            res = ID[1]
        }
    }
    return (res)
}
