var = "tDEB_BF"
type = "saisonnalité"
unit = "jour de l'année"
glose = "Début des écoulements lents (date lorsque 10% de l’intégrale sous la courbe du débit de base est atteinte)"
event = "Crue Nivale"
hydroPeriod = c("09-01", "08-31")

yearNA_lim = 10
dayNA_lim = 3
day_to_roll = NULL

functM = NULL
functM_args = NULL
isDateM = FALSE

which.minNA = function (x) {
    idMin = which.min(x)
    if (identical(idMin, integer(0))) {
        idMin = NA
    }
    return (idMin)
}

compute_tVolSnowmelt = function (X, p) {
    BF = BFS(X)
    VolSnowmelt = cumsum(BF)
    pVolSnowmelt = VolSnowmelt/max(VolSnowmelt, na.rm=TRUE)
    idp = which.minNA(abs(pVolSnowmelt - p))
    return (idp)
}

BFS = function (Q, d=5, w=0.9) {

    N = length(Q)
    if (sum(as.numeric(is.na(Q))) == N) {
        return (NA)
    }
    Slices = split(Q, ceiling(seq_along(Q)/d))
    
    idMinSlices = unlist(lapply(Slices, which.min),
                         use.names=FALSE)
    idShift = c(0, cumsum(unlist(lapply(Slices, length),
                                 use.names=FALSE)))
    idShift = idShift[-length(idShift)]
    idMin = idMinSlices + idShift
    Qmin_k = Q[idMin]

    n = length(Qmin_k)
    Qmin_kp1 = c(Qmin_k[2:n], NA)
    Qmin_km1 = c(NA, Qmin_k[1:(n-1)])
    test = w * Qmin_k < pmin(Qmin_km1, Qmin_kp1)
    test[is.na(test)] = FALSE
    idPivots = idMin[which(test)]
    Pivots = Qmin_k[test]

    # BF = approx(idPivots, Pivots, xout=1:N)$y

    nbNAid = length(idPivots[!is.na(idPivots)])
    nbNA = length(Pivots[!is.na(Pivots)])
    if (nbNAid >= 2 & nbNA >= 2) {
        BF = approxExtrap(idPivots, Pivots, xout=1:N,
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


functY = compute_tVolSnowmelt
functY_args = list(p=0.1)
isDateY = TRUE

functYT_ext = NULL
functYT_ext_args = NULL
isDateYT_ext = FALSE
functYT_sum = NULL
functYT_sum_args = NULL
