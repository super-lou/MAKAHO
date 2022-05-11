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
# R/marker_manager.R


# Sourcing dependencies
source(file.path('R', 'dependencies.R'), encoding='UTF-8')


create_marker = function (resources_path, widthRel=1, filedir='marker', color='grey50', fill_PaletteName='perso', nColor=256, reverse=TRUE, stroke=1.5, fillAdd=NULL, colorAdd=NULL, ...) {

    # Names of a temporary directory to store all the independent pages
    outdir = file.path(resources_path, filedir)
    # Creates it if it does not exist
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    # If it already exists it deletes the pre-existent directory
    # and recreates one
    } else {
        unlink(outdir, recursive=TRUE)
        dir.create(outdir)
    }
    
    Palette = get_palette(nColor=nColor,
                      palette_name=fill_PaletteName,
                      reverse=reverse)
    if (!is.null(fillAdd)) {
        Palette = c(Palette, fillAdd)
    }
    nColorPalette = length(Palette)

    Color = rep(color, nColor)
    if (!is.null(colorAdd)) {
        Color = c(Color, colorAdd)
    }
    
    Shapes = c(21, 24, 25)
    Sizes = c(6, 7, 7)*widthRel
    Y = c(0, -0.02, 0.02)
    nMark = length(Shapes)
    
    Urls = c()
    for (i in 1:nColorPalette) {

        fill = Palette[i]
        color = Color[i]
        Filenames = paste0(Shapes, fill, '.svg')
        
        for (j in 1:nMark) {

            p = ggplot() + theme_void() +
                geom_point(aes(x=0, y=Y[j]), size=Sizes[j], stroke=stroke,
                           shape=Shapes[j], color=color, fill=fill, ...) +
                # X axis of the colorbar
                scale_x_continuous(limits=c(-0.1, 0.1),
                                   expand=c(0, 0)) +
                # Y axis of the colorbar
                scale_y_continuous(limits=c(-0.1, 0.1),
                                   expand=c(0, 0)) +
                # Margin of the colorbar
                theme(plot.margin=margin(t=0, r=0, b=0, l=0, unit="mm"))
            
            ggsave(plot=p,
                   path=outdir,
                   filename=Filenames[j],
                   width=100, height=100, units='px') # 100 px = 24 pt
            Urls = c(Urls, file.path(outdir, Filenames[j]))
        }
    }
    return (Urls)
}

# create_marker(resources_path, widthRel=0.8, stroke=0.8,
#               fill_PaletteName='perso',
#               color=grey50COL,
#               fillAdd=c(grey94COL, grey50COL, grey18COL),
#               colorAdd=c(grey85COL, grey50COL, grey9COL))


get_marker = function (shape, fill, resources_path, filedir) {

    if (shape == 'o') {
        shape = 21
    } else if (shape == '^') {
        shape = 24
    } else if (shape == 'v') {
        shape = 25
    }
    
    filename = paste0(shape, fill, '.svg')
    marker = makeIcon(file.path(resources_path, filedir, filename))
    return (marker)
}

# get_marker('o', '#0F3C57', resources_path, 'marker')

get_markerList = function (shapeList, fillList, resources_path, filedir='marker', width=20) {

    nMarkF = length(fillList)
    nMarkS = length(shapeList)
    if (nMarkF != nMarkS) {
        stop("fillList and shapeList have not the same length")
    } else {
        nMark = nMarkF
    }
    
    markerList = list()
    for (i in 1:nMark) {
        marker = get_marker(shapeList[i], fillList[i],
                            resources_path, filedir)
        markerList = append(markerList, marker)
    }
    # Not possible to resize with svg but 32 is the default
    # size hence the 16 for anchoring
    markerList = icons(markerList,
                       # iconWidth=24, iconHeight=24,
                       iconAnchorX=16, iconAnchorY=16) 
    return (markerList)
}

# markerList = get_markerList(c('o', '^', 'v'), c('#1B727D', '#0F3C57', '#C97C5E'), resources_path, 'marker', width=20)

