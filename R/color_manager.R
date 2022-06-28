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


Palette_ground = c('#543005',
                   '#8c510a',
                   '#bf812d',
                   '#dfc27d',
                   '#f6e8c3',
                   '#c7eae5',
                   '#80cdc1',
                   '#35978f',
                   '#01665e',
                   '#003c30')

Palette_rainbow = c('#67001f',
                    '#b2182b',
                    '#d6604d',
                    '#f4a582',
                    '#fddbc7',
                    '#d1e5f0',
                    '#92c5de',
                    '#4393c3',
                    '#2166ac',
                    '#053061')

# Personnal colors
grey99COL = "#fcfcfc"
grey98COL = "#fafafa"
grey97COL = "#f7f7f7"
grey94COL = "#f0f0f0"
grey90COL = "#e5e5e5"
grey85COL = "#d9d9d9"
grey75COL = "#bfbfbf"
grey70COL = "#b3b3b3"
grey50COL = "#808080"
grey40COL = "#666666"
grey30COL = "#4d4d4d"
grey20COL = "#333333"
grey18COL = "#2e2e2e"
grey15COL = "#262626"
grey9COL = "#171717"

yellowCOL = "#fddc5c"
orangeCOL = "#ffa62b"
redCOL = "#dc343b"

lightCyanCOL = "#66c1bf"
midCyanCOL = "#008c8e"
darkCyanCOL = "#275662"
INRAECyanCOL = "#00a3a6"


## 1. COLOR MANAGEMENT
### 1.1. Color on colorbar ___________________________________________
compute_colorBin = function (min, max, Palette, colors=256,
                             reverse=FALSE) {

    # Gets the number of discrete colors in the palette
    nSample = length(Palette)

    if (reverse) {
        Palette = rev(Palette)
    }
    # Recreates a continuous color palette
    PaletteColors = colorRampPalette(Palette)(colors)

    # Computes the absolute max
    maxAbs = max(abs(max), abs(min))

    bin = seq(-maxAbs, maxAbs, length.out=colors-1)
    upBin = c(bin, Inf)
    lowBin = c(-Inf, bin)

    res = list(Palette=PaletteColors, bin=bin, upBin=upBin, lowBin=lowBin)
    return (res)
}

compute_color = function (value, min, max, Palette, colors=256, reverse=FALSE) {

    # If the value is a NA return NA color
    if (is.na(value)) {
        return (NA)
    }
    
    res = compute_colorBin(min=min, max=max, Palette=Palette,
                           colors=colors, reverse=reverse)
    upBin = res$upBin
    lowBin = res$lowBin
    PaletteColors = res$Palette

    if (value >= 0) {
        id = which(value < upBin & value >= lowBin)
    } else {
        id = which(value <= upBin & value > lowBin)
    }
    color = PaletteColors[id]
    return(color)
}

# compute_color(-51, -50, 40, Palette, colors=10)


get_color = function (value, min, max, Palette, CodeSample, colors=256, reverse=FALSE, noneColor='black') {
    
    color = sapply(value, compute_color,
                   min=min,
                   max=max,
                   Palette=Palette,
                   colors=colors,
                   reverse=reverse)
    
    color[is.na(color)] = noneColor    
    return(color)
}


### 1.3. Palette tester ______________________________________________
# Allows to display the current personal palette
palette_tester = function (Palette, colors=256) {

    outdir = 'palette'
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    }

    # An arbitrary x vector
    X = 1:colors
    # All the same arbitrary y position to create a colorbar
    Y = rep(0, times=colors)

    # Recreates a continuous color palette
    Palette = colorRampPalette(Palette)(colors)

    # Open a void plot
    p = ggplot() + theme_void()

    for (x in X) {
        # Plot the palette
        p = p +
            annotate("segment",
                     x=x, xend=x,
                     y=0, yend=1,
                     color=Palette[x], size=1)
    }

    p = p +
        scale_x_continuous(limits=c(0, colors),
                           expand=c(0, 0)) +
        
        scale_y_continuous(limits=c(0, 1),
                           expand=c(0, 0))

    # Saves the plot
    outname = deparse(substitute(Palette))
    
    ggsave(plot=p,
           path=outdir,
           filename=paste(outname, '.pdf', sep=''),
           width=10, height=10, units='cm', dpi=100)

    ggsave(plot=p,
           path=outdir,
           filename=paste(outname, '.png', sep=''),
           width=10, height=10, units='cm', dpi=300)
}


get_palette = function (Palette, colors=256) {
    
    # Gets the number of discrete colors in the palette
    nSample = length(Palette)
    # Recreates a continuous color palette
    Palette = colorRampPalette(Palette)(colors)

    return (Palette)
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
