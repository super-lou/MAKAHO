# \\\
# Copyright 2022 Louis Héraut*1
#
# *1   INRAE, France
#      louis.heraut@inrae.fr
#      https://github.com/super-lou
#
# This file is part of sht R toolbox.
#
# Sht R toolbox is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# Sht R toolbox is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with sht R toolbox.
# If not, see <https://www.gnu.org/licenses/>.
# ///
#
#
# R/color_manager.R


# Sourcing dependencies
source(file.path('R', 'dependencies.R'), encoding='UTF-8')


PalettePerso = c('#0f3b57', # cold
                 '#1d7881',
                 '#80c4a9',
                 '#e2dac6', # mid
                 '#fadfad',
                 '#d08363',
                 '#7e392f') # hot

# Personnal colors
grey99COL = "#fcfcfc"
grey98COL = "#fafafa"
grey97COL = "#f7f7f7"
grey94COL = "#f0f0f0"
grey85COL = "#d9d9d9"
grey70COL = "#b3b3b3"
grey50COL = "#808080"
grey30COL = "#4d4d4d"
grey20COL = "#333333"
grey18COL = "#2e2e2e"
grey15COL = "#262626"
grey9COL = "#171717"


## 1. COLOR MANAGEMENT
### 1.1. Color on colorbar ___________________________________________
# Returns a color of a palette corresponding to a value included
# between the min and the max of the variable
get_color = function (value, min, max, nbTick, nColor=256, palette_name='perso', reverse=FALSE) {

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

    labTick = pretty(seq(min, max, length.out=nbTick),
                     nbTick)

    # Computes the absolute max
    maxAbs = max(abs(max), abs(min),
                 abs(max(labTick)), abs(min(labTick)))

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
    return(color)
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

    # Open a void plot
    p = ggplot() + void

    for (x in X) {
        # Plot the palette
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
void = ggplot() + geom_blank(aes(1, 1)) +
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
