
get_trendLabel = function (code, df_XEx, df_Xtrend, type,
                           space=FALSE) {

    CodeEx = df_XEx$code[!duplicated(df_XEx$code)]
    CodeXtrend = df_Xtrend$code[!duplicated(df_Xtrend$code)]
    
    if (!(code %in% CodeEx) | !(code %in% CodeXtrend)) {
        return (NA)
    }
    
    df_XEx_code = df_XEx[df_XEx$code == code,]
    df_Xtrend_code = df_Xtrend[df_Xtrend$code == code,]

    # print(df_XEx_code)

    # if (nrow(df_XEx_code) == 0 | nrow(df_Xtrend_code) == 0) {
        # return (NA)
    if (is.na(df_Xtrend_code$trend)) {
        return (NA)
    }
    
    # Computes the mean of the data on the period
    dataMean = mean(df_XEx_code$Value,
                    na.rm=TRUE)
    
    # Gets the trend
    trend = df_Xtrend_code$trend
    
    # Computes the mean trend
    trendMean = trend/dataMean
    # Computes the magnitude of the trend
    power = get_power(trend)
    # Converts it to character
    powerC = as.character(power)
    
    # If the power is positive
    if (power >= 0) {
        # Adds a space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        shiftC = '  '
        # Otherwise
    } else {
        # No space is added
        shiftC = ''
    }

    # Gets the power of ten of magnitude
    brk = 10^power
    # Converts trend to character for sientific expression
    trendC = as.character(format(round(trend / brk, 2),
                                 nsmall=2))
    # If the trend is positive
    if (trend >= 0) {
        # Adds two space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        trendC = paste(' ', trendC, sep='')
    }
    # Converts mean trend to character
    trendMeanC = as.character(format(round(trendMean*100, 2),
                                     nsmall=2))
    if (trendMean >= 0) {
        # Adds two space in order to compensate for the minus
        # sign that sometimes is present for the other periods
        trendMeanC = paste(' ', trendMeanC, sep='')
    }

    if (space) {
        space = "    "
    } else {
        space = "&emsp;"
    }
        
    # If it is a flow variable
    if (type == 'sévérité') {
        # Create the name of the trend
        label = paste0(
            "<b>", trendC, " x ",
            "10<sup>", powerC, "</sup></b>", shiftC,
            " [m<sup>3</sup>.s<sup>-1</sup>.an<sup>-1</sup>]",
            space, "<b>",
            trendMeanC, "</b> [%.an<sup>-1</sup>]")
        
        # If it is a date variable
    } else if (type == 'saisonnalité') {
        # Create the name of the trend
        label = paste0(
            "<b>", trendC, " x ",
            "10<sup>", powerC, "</sup></b>", shiftC,
            " [jour.an<sup>-1</sup>]")
    }

    return (label)
}
