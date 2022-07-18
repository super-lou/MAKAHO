var = "t_BF"
type = "saisonnalité"
unit = "jour"
glose = "Durée des écoulements lents (durée entre 10% et 90% de l’intégrale sous la courbe du débit de base)"
event = "Crue Nivale"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

maxNA = function (X, na.rm=TRUE) {
    if (all(is.na(X))) {
        return (NA)
    } else {
        return (max(X, na.rm=na.rm))
    }
}

which.minNA = function (x) {
    idMin = which.min(x)
    if (identical(idMin, integer(0))) {
        idMin = NA
    }
    return (idMin)
}

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

compute_tSnowmelt = function (X, p1, p2) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt / maxNA(VolSnowmelt, na.rm=TRUE)
    idp1 = which.minNA(abs(pVolSnowmelt - p1))
    idp2 = which.minNA(abs(pVolSnowmelt - p2))
    len = idp2 - idp1 + 1
    return (len)
}

functY = compute_tSnowmelt
functY_args = list(p1=0.1, p2=0.9)
isDateY = FALSE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
