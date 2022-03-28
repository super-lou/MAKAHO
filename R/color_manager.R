PalettePerso = c('#0f3b57', # cold
                 '#1d7881',
                 '#80c4a9',
                 '#e2dac6', # mid
                 '#fadfad',
                 '#d08363',
                 '#7e392f') # hot


## 1. COLOR MANAGEMENT
### 1.1. Color on colorbar ___________________________________________
# Returns a color of a palette corresponding to a value included
# between the min and the max of the variable
get_color = function (value, min, max, nColor=256, palette_name='perso', reverse=FALSE) {

    # If the value is a NA return NA color
    if (is.na(value)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    midDown = round(nColor/2, 0)
    midUp = midDown
    if (nColor %% 2 == 0) {
        midUp = midUp + 1
    }
    if (reverse) {
        Sample_hot = 1:midDown
        Sample_cold = midUp:nColor
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
        
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    } else {
        Sample_hot = midUp:nColor
        Sample_cold = 1:midDown
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
    }
    
    nColor_hot = length(palette_hot)
    nColor_cold = length(palette_cold)

    # print(palette)
    # print('cold')
    # print(palette_cold)
    # print(Sample_cold)
    # print(nColor_cold)
    # print('hot')
    # print(palette_hot)
    # print(Sample_hot)
    # print(nColor_hot)    
    
    # Computes the absolute max
    maxAbs = max(abs(max), abs(min))

    # If the value is negative
    if (value <= 0) {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            # Gets the relative position of the value in respect
            # to its span
            idNorm = (value + maxAbs) / maxAbs
        }
        # The index corresponding
        id = round(idNorm*(nColor_cold - 1) + 1, 0)
        # The associated color
        color = palette_cold[id]
    # Same if it is a positive value
    } else {
        if (maxAbs == 0) {
            idNorm = 0
        } else {
            idNorm = value / maxAbs
        }
        id = round(idNorm*(nColor_hot - 1) + 1, 0)
        # The associated color
        color = palette_hot[id]
    }
    # print(idNorm)
    # print(id)
    # print(palette_hot)
    # print(color)
    return(color)
}

### 1.2. Colorbar ____________________________________________________
# Returns the colorbar but also positions, labels and colors of some
# ticks along it 
get_palette = function (min, max, nColor=256, palette_name='perso', reverse=FALSE, nbTick=10) {

    # If the value is a NA return NA color
    if (is.null(min) | is.null(max)) {
        return (NA)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # Gets the number of discrete colors in the palette
    nSample = length(colorList)
    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    midDown = round(nColor/2, 0)
    midUp = midDown
    if (nColor %% 2 == 0) {
        midUp = midUp + 1
    }
    if (reverse) {
        Sample_hot = 1:midDown
        Sample_cold = midUp:nColor
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
        
        palette = rev(palette)
        palette_hot = rev(palette_hot)
        palette_cold = rev(palette_cold)
    } else {
        Sample_hot = midUp:nColor
        Sample_cold = 1:midDown
        
        palette_hot = palette[Sample_hot]
        palette_cold = palette[Sample_cold]
    }
    
    nColor_hot = length(palette_hot)
    nColor_cold = length(palette_cold)

    # If the min and the max are below zero
    if (min < 0 & max < 0) {
        # The palette show is only the cold one
        paletteShow = palette_cold
    # If the min and the max are above zero
    } else if (min > 0 & max > 0) {
        # The palette show is only the hot one
        paletteShow = palette_hot
    # Else it is the entire palette that is shown
    } else {
        paletteShow = palette
    }

    # The position of ticks is between 0 and 1
    posTick = seq(0, 1, length.out=nbTick)
    # Blank vector to store corresponding labels and colors
    labTick = c()
    colTick = c()
    # For each tick
    for (i in 1:nbTick) {
        # Computes the graduation between the min and max
        lab = (i-1)/(nbTick-1) * (max - min) + min
        
        # Gets the associated color
        col = get_color(lab, min=min, max=max,
                        nColor=nColor,
                        palette_name=palette_name,
                        reverse=reverse)
        
        # Stores them
        labTick = c(labTick, lab)
        colTick = c(colTick, col)
    }
    # List of results
    res = list(palette=paletteShow, posTick=posTick,
               labTick=labTick, colTick=colTick)
    return(res)
}

### 1.3. Palette tester ______________________________________________
# Allows to display the current personal palette
palette_tester = function (palette_name='perso', figdir='figures', nColor=256) {

    outdir = file.path(figdir, 'palette')
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    }
    
    # If the palette chosen is the personal ones
    if (palette_name == 'perso') {
        colorList = PalettePerso
    # Else takes the palette corresponding to the name given
    } else {
        colorList = brewer.pal(11, palette_name)
    }
    
    # An arbitrary x vector
    X = 1:nColor
    # All the same arbitrary y position to create a colorbar
    Y = rep(0, times=nColor)

    # Recreates a continuous color palette
    palette = colorRampPalette(colorList)(nColor)

    # Open a plot
    p = ggplot() + 
        # Make the theme blank
        theme(
            plot.background = element_blank(), 
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(), 
            panel.border = element_blank(),
            panel.background = element_blank(),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            axis.text.x = element_blank(), 
            axis.text.y = element_blank(),
            axis.ticks = element_blank(),
            axis.line = element_blank()
        )

    for (x in X) {
        # Plot the palette
        # geom_line(aes(x=X, y=Y), color=palette[X], size=60,
        # shape=15)

        p = p +
            annotate("segment",
                     x=x, xend=x,
                     y=0, yend=1, 
                     color=palette[x], size=1)
    }

    p = p +
        scale_x_continuous(limits=c(0, nColor),
                           expand=c(0, 0)) +
        
        scale_y_continuous(limits=c(0, 1),
                           expand=c(0, 0))

    # Saves the plot
    ggsave(plot=p,
           path=outdir,
           filename=paste(palette_name, '.pdf', sep=''),
           width=10, height=10, units='cm', dpi=100)

    ggsave(plot=p,
           path=outdir,
           filename=paste(palette_name, '.png', sep=''),
           width=10, height=10, units='cm', dpi=300)
}


## 2. USEFUL GENERICAL PLOT __________________________________________
### 2.1. Void plot ___________________________________________________
# A plot completly blank
void = ggplot() + geom_blank(aes(1,1)) +
    theme(
        plot.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        panel.border = element_blank(),
        panel.background = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(), 
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.line = element_blank()
    )
