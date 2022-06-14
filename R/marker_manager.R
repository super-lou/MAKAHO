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


save_marker = function (y, shape, color, fill, size, stroke, outdir, ...) {

    filename = paste0(shape, '_',
                      color, '_',
                      fill, '.svg')
    
    p = ggplot() + theme_void() +
        geom_point(aes(x=0, y=y),
                   shape=shape, color=color,
                   fill=fill, size=size, stroke=stroke, ...) +
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
           filename=filename,
           width=100, height=100, units='px') # 100 px = 24 pt
    return (filename)
}

create_marker = function (shapeList, colorList, strokeList, fillPalette, shapeSizes, resources_path, filedir='marker', colors=256, size=1, relY=1, fillAdd=NULL, colorAdd=NULL, ...) {

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

    nShape = length(shapeList)
    Sizes = shapeSizes*size
    if (length(relY) != nShape) {
        relY = rep(relY[1], times=nShape)
    }

    nColor = length(colorList)
    
    fillList = get_palette(colors=colors,
                           Palette=fillPalette)
    nFill = length(fillList)

    nAdd = length(fillAdd)
    
    Urls = c()
    for (i in 1:nShape) {
        y = relY[i]
        shape = shapeList[i]
        size = Sizes[i]

        for (j in 1:nColor) {
            color = colorList[j]
            stroke = strokeList[j]
            
            for (k in 1:nFill) {
                fill = fillList[k]
                filename = save_marker(y, shape, color, fill,
                                       size, stroke, outdir, ...)
                Urls = c(Urls, file.path(outdir, filename))
            }
        }

        for (marker in markerAdd) {
            color = marker['color']
            fill = marker['fill']
            stroke = as.numeric(marker['stroke'])
            filename = save_marker(y, shape, color, fill,
                                   size, stroke, outdir, ...)
            Urls = c(Urls, file.path(outdir, filename))
        }
    }   
    
    return (Urls)
}

# markerAdd = list(
#     c(color=missColor,
#       fill=none2Color_light,
#       stroke=1),
#     c(color=missColor,
#       fill=none2Color_dark,
#       stroke=1),
    
#     c(color=validColor,
#       fill=validColor,
#       stroke=0.8),
#     c(color=none1Color_light,
#       fill=none2Color_light,
#       stroke=0.8),
#     c(color=none1Color_dark,
#       fill=none2Color_dark,
#       stroke=0.8)
#     )

# create_marker(shapeList=c(21, 24, 25),
#               colorList=c(validColor, invalidColor),
#               strokeList=c(0.8, 1),
#               fillPalette=Palette,
#               shapeSizes=c(6, 7, 7),
#               resources_path=resources_path,
#               filedir='marker',
#               colors=colors,
#               size=0.8,
#               relY=c(0, -0.02, 0.02),
#               markerAdd=markerAdd)


get_marker = function (shape, color, fill, resources_path, filedir) {

    if (shape == 'o') {
        shape = 21
    } else if (shape == '^') {
        shape = 24
    } else if (shape == 'v') {
        shape = 25
    }
    
    filename = paste0(shape, '_', color, '_', fill, '.svg')
    marker = makeIcon(file.path(resources_path, filedir, filename))
    return (marker)
}


get_markerList = function (shapeList, colorList, fillList, resources_path, filedir='marker', width=20) {

    nMark = length(fillList)
    
    markerList = list()
    for (i in 1:nMark) {
        marker = get_marker(shapeList[i], colorList[i], fillList[i],
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
