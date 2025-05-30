# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1,
#                     Éric Sauquet (eric.sauquet@inrae.fr)*1,
#                     Michel Lang (michel.lang@inrae.fr)*1,
#                     Jean-Philippe Vidal (jean-philippe.vidal@inrae.fr)*1,
#                     Benjamin Renard (benjamin.renard@inrae.fr)*1
#                     
# *1   INRAE, France
#
# This file is part of MAKAHO R shiny app.
#
# MAKAHO R shiny app is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MAKAHO R shiny app is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MAKAHO R shiny app.
# If not, see <https://www.gnu.org/licenses/>.


## 1. CREATION _______________________________________________________
save_marker = function (y, shape, color, fill, size, sizeName,
                        svgSize, stroke, outdir, name=NA, ...) {

    if (is.na(name)) {
        filename = paste0(sizeName, '_',
                          shape, '_',
                          color, '_',
                          fill,
                          '.svg')
    } else {
        filename = paste0(name, ".svg")
    }
    
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
           width=svgSize, height=svgSize, units='px') # 100 px = 24 pt
    return (filename)
}

create_marker = function (shapeList, sizeShapeList, colorList,
                          strokeColorList, sizeList, strokeSizeList,
                          nameSizeList, svgSizeList, fillPalette,
                          resources_path, filedir='marker',
                          colorStep=256, relY=1, fillAdd=NULL,
                          colorAdd=NULL, overwrite=FALSE, ...) {

    # Names of a temporary directory to store all the independent pages
    outdir = file.path(resources_path, filedir)
    # Creates it if it does not exist
    if (!(file.exists(outdir))) {
        dir.create(outdir)
    # If it already exists it deletes the pre-existent directory
    # and recreates one
    } else if (overwrite) {
        unlink(outdir, recursive=TRUE)
        dir.create(outdir)
    }

    nSize = length(sizeList)
    nShape = length(shapeList)
    if (length(relY) != nShape) {
        relY = rep(relY[1], times=nShape)
    }

    nColor = length(colorList)
    
    fillList = fillPalette
    nFill = length(fillList)

    nAdd = length(fillAdd)
    
    Urls = c()
    for (l in 1:nSize) {
        Sizes = sizeList[l]*sizeShapeList
        strokeSize = strokeSizeList[l]
        sizeName = nameSizeList[l]
        svgSize = svgSizeList[l]
        
        for (i in 1:nShape) {
            y = relY[i]
            shape = shapeList[i]
            size = Sizes[i]

            for (j in 1:nColor) {
                color = colorList[j]
                stroke = strokeColorList[j]*strokeSize
                
                for (k in 1:nFill) {
                    fill = fillList[k]
                    filename = save_marker(y, shape, color, fill,
                                           size, sizeName, svgSize,
                                           stroke, outdir, ...)
                    Urls = c(Urls, file.path(outdir, filename))
                }
            }

            for (marker in markerAdd) {
                color = marker['color']
                fill = marker['fill']
                stroke = as.numeric(marker['stroke'])*strokeSize
                alpha = as.numeric(marker['alpha'])
                name = marker['name']
                filename = save_marker(y, shape, color, fill,
                                       size, sizeName, svgSize,
                                       stroke, outdir, name=name,
                                       alpha=alpha,
                                       ...)
                Urls = c(Urls, file.path(outdir, filename))
            }
        }
    }
    
    return (Urls)
}

## /!\ NEEDS TO BE RUN ONCE TO GENERATE MARKERS ##
if (make_marker) { 
    library(ggplot2)

    markerAdd = list(
        c(color=missColor,
          fill=none2Color_light,
          stroke=1),
        c(color=missColor,
          fill=none2Color_dark,
          stroke=1),
        
        c(color=validSColor,
          fill=validSColor,
          stroke=0.8),
        c(color=none1Color_light,
          fill=none2Color_light,
          stroke=0.8),
        c(color=none1Color_dark,
          fill=none2Color_dark,
          stroke=0.8),

        c(color="black",
          fill="black",
          stroke=1,
          alpha=0,
          name="void")
    )

    create_marker(shapeList=c(21, 24, 25),
                  sizeShapeList=c(5, 7, 7),
                  colorList=c(validSColor, validNSColor, invalidColor),
                  strokeColorList=c(0.8, 0.8, 1),
                  sizeList=c(0.8, 0.8, 1.2),
                  strokeSizeList=c(1, 1, 1.4),
                  nameSizeList=c('small', 'small', 'big'),
                  svgSizeList=c(100, 100, 125),
                  fillPalette=get_IPCC_Palette("hydro_10"),
                  resources_path=resources_path,
                  filedir='marker',
                  relY=c(0, -0.02, 0.02),
                  markerAdd=markerAdd)

    create_marker(shapeList=c(21, 24, 25),
                  sizeShapeList=c(5, 7, 7),
                  colorList=c(validSColor, validNSColor, invalidColor),
                  strokeColorList=c(0.8, 0.8, 1),
                  sizeList=c(0.8, 0.8, 1.2),
                  strokeSizeList=c(1, 1, 1.4),
                  nameSizeList=c('small', 'small', 'big'),
                  svgSizeList=c(100, 100, 125),
                  fillPalette=get_IPCC_Palette("temperature_10"),
                  resources_path=resources_path,
                  filedir='marker',
                  relY=c(0, -0.02, 0.02),
                  markerAdd=markerAdd)

    create_marker(shapeList=c(21, 24, 25),
                  sizeShapeList=c(5, 7, 7),
                  colorList=c(validSColor, validNSColor, invalidColor),
                  strokeColorList=c(0.8, 0.8, 1),
                  sizeList=c(0.8, 0.8, 1.2),
                  strokeSizeList=c(1, 1, 1.4),
                  nameSizeList=c('small', 'small', 'big'),
                  svgSizeList=c(100, 100, 125),
                  fillPalette=get_IPCC_Palette("date_10"),
                  resources_path=resources_path,
                  filedir='marker',
                  relY=c(0, -0.02, 0.02),
                  markerAdd=markerAdd)
}
##################################################


## 2. GET ____________________________________________________________
get_marker = function (size, shape, color, fill,
                       resources_path, filedir) {

    if (!is.null(shape)) {
        if (shape == 'o') {
            shape = 21
        } else if (shape == '^') {
            shape = 24
        } else if (shape == 'v') {
            shape = 25
        }
    }

    filename = paste0(c(size, shape, color, fill), collapse="_")
    filename = paste0(filename, '.svg')
    marker = makeIcon(file.path(resources_path, filedir, filename))
    return (marker)
}

get_markerList = function (sizeList, shapeList=NULL, colorList=NULL, fillList=NULL, resources_path="", filedir='marker', width=20) {

    nMark = length(sizeList)
    
    markerList = list()
    for (i in 1:nMark) {
        marker = get_marker(sizeList[i], shapeList[i], colorList[i],
                            fillList[i], resources_path, filedir)
        markerList = append(markerList, marker)
    }
    # Not possible to resize with svg but 32 is the default
    # size hence the 16 for anchoring
    markerList = icons(markerList,
                       # iconWidth=24, iconHeight=24,
                       iconAnchorX=16, iconAnchorY=16) 
    return (markerList)
}
