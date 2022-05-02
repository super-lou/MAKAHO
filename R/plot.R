
### 1.1. Personal theme ______________________________________________
theme_ash =
    theme(
        # White background
        panel.background=element_rect(fill='white'),
        # Font
        text=element_text(family='sans'),
        # Border of plot
        panel.border = element_rect(color="grey85",
                                    fill=NA,
                                    size=0.5),
        # Grid
        panel.grid.major.x=element_blank(),
        panel.grid.major.y=element_blank(),
        # Ticks marker
        axis.ticks.x=element_line(color='grey75', size=0.2),
        axis.ticks.y=element_line(color='grey75', size=0.2),
        # Ticks label
        axis.text.x=element_text(size=4, color='grey40'),
        axis.text.y=element_text(size=4, color='grey40'),
        # Ticks length
        axis.ticks.length=unit(0.7, 'mm'),
        # Ticks minor
        ggh4x.axis.ticks.length.minor=rel(0.5),
        # Title
        plot.title=element_blank(),
        # Axis title
        axis.title.x=element_blank(),
        axis.title.y=element_text(size=4, vjust=0.4, 
                                  hjust=0.5, color='grey20'),
        # Axis line
        axis.line.x=element_blank(),
        axis.line.y=element_blank(),
        )


### 2.1. Time panel __________________________________________________
time_panel = function (df_data_code, df_trend_code, var, type,
                       linetype='solid', alpha=0.1, missRect=FALSE,
                       unit2day=365.25, trend_period=NULL, grid=TRUE,
                       ymin_lim=NULL, color=NULL, NspaceMax=NULL,
                       first=FALSE, last=FALSE, lim_pct=10) {
    
    # Compute max and min of flow
    maxQ = max(df_data_code$Value, na.rm=TRUE)
    minQ = min(df_data_code$Value, na.rm=TRUE)

    spread = maxQ - minQ
    
    nTick = 6
    maxQ_win = maxQ + spread*lim_pct/100
    minQ_win = minQ - spread*lim_pct/100

    if (minQ_win < 0) {
        minQtmp_lim = 0
    } else {
        minQtmp_lim = minQ_win
    }

    if (!is.null(ymin_lim)) {
        minQ_win = ymin_lim
    }
    
    spreadtmp = maxQ_win - minQtmp_lim
    
    breakQtmp = spreadtmp / (nTick - 1)

    GradQ_10 = c(0, 1, 1.5, 2, 2.5, 3, 4, 5, 10)

    Grad = GradQ_10 * 10^get_power(breakQtmp)
    dist = abs(Grad - breakQtmp)
    idGrad = which.min(dist)
    breakQ = Grad[idGrad]
    
    if (is.null(ymin_lim)) {
        Grad = GradQ_10 * 10^get_power(minQtmp_lim)      
        Grad[Grad > minQtmp_lim] = NA        
        dist = abs(Grad - minQtmp_lim)        
        idGrad = which.min(dist)        
        minQ_lim = Grad[idGrad]        
    } else {        
        minQ_lim = ymin_lim
    }
    maxQ_list = c()
    i = 1
    maxQtmp = minQ_lim
    
    while (maxQtmp <= maxQ_win) {
        maxQtmp = minQ_lim + i*breakQ
        i = i + 1
    }   
    maxQ_lim = maxQtmp    
        
    minor_minDatetmp_lim = as.Date(df_data_code$Date[1]) 
    minor_maxDatetmp_lim =
        as.Date(df_data_code$Date[length(df_data_code$Date)])

    minor_minDatetmp_lim = as.numeric(format(minor_minDatetmp_lim, "%Y"))
    minor_maxDatetmp_lim = as.numeric(format(minor_maxDatetmp_lim, "%Y"))

    minDatetmp_lim = minor_minDatetmp_lim
    maxDatetmp_lim = minor_maxDatetmp_lim

    nTick = 8
    
    spreadtmp = minor_maxDatetmp_lim - minor_minDatetmp_lim
    breakDatetmp = spreadtmp / (nTick - 1)

    GradDate_10 = c(1, 2.5, 5, 10)

    Grad = GradDate_10 * 10^get_power(breakDatetmp)
    dist = abs(Grad - breakDatetmp)
    idGrad = which.min(dist)
    breakDate = Grad[idGrad]

    listDate = seq(round(minDatetmp_lim, -1)-10^(get_power(breakDate)+1),
                   round(maxDatetmp_lim, -1)+10^(get_power(breakDate)+1),
                   by=breakDate)

    minDate_lim = listDate[which.min(abs(listDate - minDatetmp_lim))]
    maxDate_lim = listDate[which.min(abs(listDate - maxDatetmp_lim))]
    minDate_lim = as.Date(paste(minDate_lim, '-01-01', sep=''))
    maxDate_lim = as.Date(paste(maxDate_lim, '-01-01', sep=''))


    minor_breakDatetmp = breakDate / 5
    
    GradMinorDate_10 = c(1, 2, 5, 10)

    Grad = GradMinorDate_10 * 10^get_power(minor_breakDatetmp)
    dist = abs(Grad - minor_breakDatetmp)
    idGrad = which.min(dist)
    minor_breakDate = Grad[idGrad]
    
    listDate = seq(round(minor_minDatetmp_lim,
                         -1) - 10^(get_power(minor_breakDate)+1),
                   round(minor_maxDatetmp_lim,
                         -1) + 10^(get_power(minor_breakDate)+1),
                   by=minor_breakDate)

    minor_minDate_lim =
        listDate[which.min(abs(listDate - minor_minDatetmp_lim))]
    minor_maxDate_lim =
        listDate[which.min(abs(listDate - minor_maxDatetmp_lim))]
    minor_minDate_lim = as.Date(paste(round(minor_minDate_lim),
                                      '-01-01', sep=''))
    minor_maxDate_lim = as.Date(paste(round(minor_maxDate_lim),
                                      '-01-01', sep=''))
    
    # Open new plot
    p = ggplot() + theme_ash + 
        theme(plot.margin=margin(t=0, r=0, b=0, l=0, unit="mm"))

    # # Margins
    # if (first) {
    #     p = p + 
    #         theme(plot.margin=margin(t=2.5, r=0, b=3, l=0, unit="mm"))
    # } else if (last) {
    #     p = p + 
    #         theme(plot.margin=margin(t=2, r=0, b=0, l=0, unit="mm"))
    # } else if (first & last) {
    #     p = p + 
    #         theme(plot.margin=margin(t=2.5, r=0, b=0, l=0, unit="mm"))
    # } else {
    #     p = p + 
    #         theme(plot.margin=margin(t=2, r=0, b=2, l=0, unit="mm"))
    # }


    ### Grid ###
    if (grid) {
        # The min and the max is set by
        # the min and the max of the date data 
        xmin = min(df_data_code$Date)
        xmax = max(df_data_code$Date)
            
        # Create a vector for all the y grid position
        ygrid = seq(minQ_win, maxQ_win, breakQ)
        # Blank vector to store position
        ord = c() 
        abs = c()
        # For all the grid element
        for (i in 1:length(ygrid)) {
            # Store grid position
            ord = c(ord, rep(ygrid[i], times=2))
            abs = c(abs, xmin, xmax)
        }
        # Create a tibble to store all the position
        plot_grid = tibble(abs=as.Date(abs), ord=ord)
        # Plot the y grid
        p = p +
            geom_line(data=plot_grid, 
                      aes(x=abs, y=ord, group=ord),
                      color='grey85',
                      size=0.15)
    }

    
    ### Data ###
    # If it is a square root flow or flow
    if (var == 'sqrt(Q)' | var == 'Q') {
        # Plot the data as line
        p = p +
            geom_line(aes(x=df_data_code$Date, y=df_data_code$Value),
                      color='grey20',
                      size=0.2,
                      lineend="round")
    } else {
        # Plot the data as point
        p = p +
            geom_point(aes(x=df_data_code$Date, y=df_data_code$Value),
                       shape=19, color='grey50', alpha=1,
                       stroke=0, size=0.75)
    }

    ### Missing data ###
    # If the option is TRUE
    if (missRect) {
        # Remove NA data
        NAdate = df_data_code$Date[is.na(df_data_code$Value)]
        # Get the difference between each point of date data without NA
        dNAdate = diff(NAdate)
        # If difference of day is not 1 then
        # it is TRUE for the beginning of each missing data period 
        NAdate_Down = NAdate[append(Inf, dNAdate) != 1]
        # If difference of day is not 1 then
        # it is TRUE for the ending of each missing data period 
        NAdate_Up = NAdate[append(dNAdate, Inf) != 1]

        # Plot the missing data period
        p = p +
            geom_rect(aes(xmin=NAdate_Down, 
                          ymin=minQ_win, 
                          xmax=NAdate_Up, 
                          ymax=maxQ_win),
                      linetype=0, fill='Wheat', alpha=0.4)
    }
    
    
    ### Trend ###
    # If there is trends
    if (!is.null(df_trend_code)) {

        # Extract start and end of trend periods
        Start = df_trend_code$period_start
        End = df_trend_code$period_end

        # Computes the mean of the data on the period
        dataMean = mean(df_data_code$Value,
                        na.rm=TRUE)        

        # Search for the index of the closest existing date 
        # to the start of the trend period of analysis
        iStart = which.min(abs(df_data_code$Date - Start))
        # Same for the end
        iEnd = which.min(abs(df_data_code$Date - End))

        # Get the start and end date associated
        xmin = df_data_code$Date[iStart]
        xmax = df_data_code$Date[iEnd]

        # Create vector to store x data
        abs = c(xmin, xmax)
        # Convert the number of day to the unit of the period
        abs_num = as.numeric(abs) / unit2day
        # Compute the y of the trend
        ord = abs_num * df_trend_code$trend +
            df_trend_code$intercept

        # Create temporary tibble with variable to plot
        plot_trend = tibble(abs=abs, ord=ord)

        # The entire date data is selected
        codeDate = df_data_code$Date

        # The y limit is stored in a vector
        codeValue = c(minQ_win, maxQ_win)

        # Position of the x beginning and end of the legend symbol
        x = gpct(1.5, codeDate, shift=TRUE)
        xend = x + gpct(3, codeDate)

        # Spacing between legend symbols
        dy = gpct(9, codeValue, min_lim=ymin_lim)
        # Position of the y beginning and end of the legend symbol
        y = gpct(92, codeValue, min_lim=ymin_lim, shift=TRUE)
        yend = y

        # Position of x for the beginning of the associated text
        xt = xend + gpct(1, codeDate)

        # Position of the background rectangle of the legend
        xminR = x - gpct(1, codeDate)
        yminR = y - gpct(5, codeValue, min_lim=ymin_lim)
        # If it is a flow variable
        if (type == 'sévérité') {
            xmaxR = x + gpct(32.5, codeDate)
            # If it is a date variable
        } else if (type == 'saisonnalité' | type == 'pluviométrie' | type == 'température' | type == 'évapotranspiration') {
            xmaxR = x + gpct(20.5, codeDate)
        }
        ymaxR = y + gpct(5, codeValue, min_lim=ymin_lim)

        # Gets the trend
        trend = df_trend_code$trend
        # Gets the p value
        pVal = df_trend_code$p

        if (pVal <= alpha) {
            colorLine = color
            colorLabel = color
        } else {
            colorLine = 'grey85'
            colorLabel = 'grey85'
        }

        # Computes the mean trend
        trendMean = trend/dataMean
        # Computes the magnitude of the trend
        power = get_power(trend)
        # Converts it to character
        powerC = as.character(power)
        # If the power is positive
        if (powerC >= 0) {
            # Adds a space in order to compensate for the minus
            # sign that sometimes is present for the other periods
            spaceC = '  '
            # Otherwise
        } else {
            # No space is added
            spaceC = ''
        }

        # Gets the power of ten of magnitude
        brk = 10^power
        # Converts trend to character for sientific expression
        trendC = as.character(format(round(trend / brk, 2),
                                     nsmall=2))
        # If the trend is positive
        if (trendC >= 0) {
            # Adds two space in order to compensate for the minus
            # sign that sometimes is present for the other periods
            trendC = paste('  ', trendC, sep='')
        }
        # Converts mean trend to character
        trendMeanC = as.character(format(round(trendMean*100, 2),
                                         nsmall=2))
        if (trendMeanC >= 0) {
            # Adds two space in order to compensate for the minus
            # sign that sometimes is present for the other periods
            trendMeanC = paste('  ', trendMeanC, sep='')
        }

        # Create temporary tibble with variable to plot legend
        leg_trend = tibble(x=x, xend=xend, 
                           y=y, yend=yend, 
                           xt=xt,
                           colorLine=colorLine,
                           colorLabel=colorLabel,
                           trendC=trendC,
                           powerC=powerC,
                           spaceC=spaceC,
                           trendMeanC=trendMeanC,
                           xminR=xminR, yminR=yminR,
                           xmaxR=xmaxR, ymaxR=ymaxR)

        linetypeLeg = linetype
        linetypeLeg[linetype == 'longdash'] = '33'
        linetypeLeg[linetype == 'dashed'] = '22'
        linetypeLeg[linetype == 'dotted'] = '11'

        # Plot the background for legend
        p = p +
            geom_rect(data=leg_trend,
                      aes(xmin=xminR, 
                          ymin=yminR, 
                          xmax=xmaxR, 
                          ymax=ymaxR),
                      linetype=0, fill='white', alpha=0.3)

        # Get the character variable for naming the trend
        colorLine = leg_trend$colorLine
        colorLabel = leg_trend$colorLabel
        trendC = leg_trend$trendC
        powerC = leg_trend$powerC
        spaceC = leg_trend$spaceC
        trendMeanC = leg_trend$trendMeanC

        # If it is a flow variable
        if (type == 'sévérité') {
            # Create the name of the trend
            label = bquote(bold(.(trendC)~'x'~'10'^{.(powerC)}*.(spaceC))~'['*m^{3}*'.'*s^{-1}*'.'*an^{-1}*']'~~bold(.(trendMeanC))~'[%.'*an^{-1}*']')
            
            # If it is a date variable
        } else if (type == 'saisonnalité') {
            # Create the name of the trend
            label = bquote(bold(.(trendC)~'x'~'10'^{.(powerC)}*.(spaceC))~'[jour.'*an^{-1}*']')
        }
        
        # Plot the trend symbole and value of the legend
        p = p +
            annotate("segment",
                     x=leg_trend$x, xend=leg_trend$xend,
                     y=leg_trend$y, yend=leg_trend$yend,
                     color=colorLine,
                     linetype=linetypeLeg,
                     lwd=0.6,
                     lineend="round") +
            
            annotate("text",
                     label=label, size=1.5,
                     x=leg_trend$xt, y=leg_trend$y, 
                     hjust=0, vjust=0.5,
                     color=colorLabel) + 
            
            # Plot the line of white background of each trend
            geom_line(data=plot_trend, 
                      aes(x=abs, y=ord),
                      color='white',
                      linetype='solid',
                      size=1,
                      lineend="round") +
            
            # Plot the line of trend
            geom_line(data=plot_trend, 
                      aes(x=abs, y=ord),
                      color=color,
                      linetype=linetype,
                      size=0.5,
                      lineend="round")
    }

    # Y axis title
    # If it is a flow variable
    if (type == 'sévérité' | var == 'Q') {
        p = p +
            ylab(bquote(bold(.(var))~~'['*m^{3}*'.'*s^{-1}*']'))
    } else if (var == 'sqrt(Q)') {
        p = p +
            ylab(bquote(bold(.(var))~~'['*m^{3/2}*'.'*s^{-1/2}*']'))
    # If it is a date variable
    } else if (type == 'saisonnalité') {
        p = p +
            ylab(bquote(bold(.(var))~~"[jour de l'année]"))
    }
    
    if (!last & !first) {
        p = p + 
            theme(axis.text.x=element_blank())
    }

    if (first) {
        position = 'top'
    } else {
        position = 'bottom'
    }

    limits = c(min(df_data_code$Date), max(df_data_code$Date))

    if (breakDate < 1) {
        breaks = waiver()
        minor_breaks = waiver()
        date_labels = waiver()
    } else {
        breaks = seq(minDate_lim, maxDate_lim,
                     by=paste(breakDate, 'years'))
        minor_breaks = seq(minor_minDate_lim,
                           minor_maxDate_lim,
                           by=paste(minor_breakDate,
                                    'years'))
        date_labels = "%Y"
    }

    # Parameters of the x axis contain the limit of the date data
    p = p +
        scale_x_date(breaks=breaks,
                     minor_breaks=minor_breaks,
                     guide='axis_minor',
                     date_labels=date_labels,
                     limits=limits,
                     position=position, 
                     expand=c(0, 0))    
    
    # If it is a date variable 
    if (type == 'saisonnalité') {
        # The number of digit is 6 because months are display
        # with 3 characters
        Nspace = 6
        
        prefix = strrep(' ', times=NspaceMax-Nspace)
        accuracy = NULL
        
    # If it is a flow variable
    } else if (type == 'sévérité' | type == 'data' | type == 'pluviométrie' | type == 'température' | type == 'évapotranspiration') {
        # Gets the max number of digit on the label
        maxtmp = max(df_data_code$Value, na.rm=TRUE)
        # Taking into account of the augmentation of
        # max for the window
        maxtmp = maxtmp * (1 + lim_pct/100)

        # If the max is greater than 10
        if (maxtmp >= 10) {
            # The number of digit is the magnitude plus
            # the first number times 2
            Nspace = (get_power(maxtmp) + 1)*2
            # Plus spaces between thousands hence every 8 digits
            Nspace = Nspace + as.integer(Nspace/8)            
            # Gets the associated number of white space
            prefix = strrep(' ', times=NspaceMax-Nspace)
            # The accuracy is 1
            accuracy = 1
            
        # If the max is less than 10 and greater than 1
        } else if (maxtmp < 10 & maxtmp >= 1) {
            # The number of digit is the magnitude plus
            # the first number times 2 plus 1 for the dot
            # and 2 for the first decimal
            Nspace = (get_power(maxtmp) + 1)*2 + 3
            # Gets the associated number of white space
            prefix = strrep(' ', times=NspaceMax-Nspace)
            # The accuracy is 0.1
            accuracy = 0.1
            
        # If the max is less than 1 (and obviously more than 0)
        } else if (maxtmp < 1) {
            # Fixes the number of significant decimals to 3
            maxtmp = signif(maxtmp, 3)
            # The number of digit is the number of character
            # of the max times 2 minus 1 for the dots that
            # count just 1 space
            Nspace = nchar(as.character(maxtmp))*2 - 1
            # Gets the associated number of white space
            prefix = strrep(' ', times=NspaceMax-Nspace)
            # Computes the accuracy
            accuracy = 10^(-nchar(as.character(maxtmp))+2)
        }
    }
    
    # Parameters of the y axis
    # If it is a flow variable
    if (type == 'sévérité' | type == 'data' | type == 'pluviométrie' | type == 'température' | type == 'évapotranspiration') {        
        p = p +
            scale_y_continuous(breaks=seq(minQ_lim, maxQ_lim, breakQ),
                               limits=c(minQ_win, maxQ_win),
                               expand=c(0, 0),
                               labels=number_format(accuracy=accuracy,
                                                    prefix=prefix))
    # If it is a date variable
    } else if (type == 'saisonnalité') {
        # monthNum = as.numeric(format(seq(as.Date(minQ_lim),
                                       # as.Date(maxQ_lim),
                                       # by=paste(breakQ, 'days')),
        # "%m"))

        monthStart = as.Date(paste(substr(as.Date(minQ_lim), 1, 7),
                                   '-01', sep=''))
        monthEnd = as.Date(paste(substr(as.Date(maxQ_lim), 1, 7),
                                 '-01', sep=''))

        byMonth = round(breakQ/30.4, 0)
        if (byMonth == 0) {
            byMonth = 1
        }
        
        breaksDate = seq(monthStart, monthEnd,
                         by=paste(byMonth, 'months'))
        breaksNum = as.numeric(breaksDate)
        breaksMonth = as.numeric(format(breaksDate, "%m"))

        monthName = c('Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jui',
                      'Jui', 'Aou', 'Sep', 'Oct', 'Nov', 'Déc')      
        monthName = paste(prefix, monthName, sep='')
        
        labels = monthName[breaksMonth]
        
        p = p +
            scale_y_continuous(breaks=breaksNum,
                               limits=c(minQ_win, maxQ_win),
                               labels=labels,  
                               expand=c(0, 0))
        
    }
    return(p)
}
