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
# plot.R


### 1.2. Colorbar ____________________________________________________
# Returns the colorbar but also positions, labels and colors of some
# ticks along it 
plot_colorbar = function (rv, type, Palette, colors=256, reverse=FALSE) {
    
    res = compute_colorBin(min=rv$minValue,
                           max=rv$maxValue,
                           Palette=Palette,
                           colors=colors,
                           reverse=reverse)

    bin = res$bin
    upBin = res$upBin
    Y1 = upBin / max(upBin[is.finite(upBin)])
    dY = mean(diff(Y1[is.finite(Y1)]))
    Y1[Y1 == Inf] = 1 + dY
    
    lowBin = res$lowBin
    Y0 = lowBin / max(lowBin[is.finite(lowBin)])
    Y0[Y0 == -Inf] = -1 - dY

    PaletteColors = res$Palette
    X0 = rep(0, colors)
    X1 = rep(1, colors)
    
    # Computes the histogram of values
    res = hist(rv$df_value$value,
               breaks=c(-Inf, bin, Inf),
               plot=FALSE)
    # Extracts the number of counts per cells
    counts = res$counts

    fig = plotly_empty(width=55, height=250)
    
    for (i in 2:(colors-1)) {
        fig = add_trace(fig,
                        type="scatter",
                        mode="lines",
                        x=c(X0[i], X0[i], X1[i], X1[i], X0[i]),
                        y=c(Y0[i], Y1[i], Y1[i], Y0[i], Y0[i]),
                        fill="toself",
                        fillcolor=PaletteColors[i],
                        line=list(width=0),
                        text=paste0("<b>",
                                    counts[i],
                                    "</b>",
                                    "<br>stations"),
                        hoverinfo="text",
                        hoveron="fills",
                        hoverlabel=list(bgcolor=counts[i],
                                        font=list(color="white",
                                                  size=12),
                                        bordercolor="white"))
    }
    
    fig = layout(fig,
                 xaxis=list(range=c(-1.5, 3.4),
                            showticklabels=FALSE,
                            fixedrange=TRUE),
                 yaxis=list(range=c(-1-dY*2/3, 1+dY*2/3),
                            showticklabels=FALSE,
                            fixedrange=TRUE),
                 margin=list(l=0,
                             r=0,
                             b=0,
                             t=0,
                             pad=0),
                 autosize=FALSE,
                 plot_bgcolor='transparent',
                 paper_bgcolor='transparent',
                 showlegend=FALSE)
    
    fig = add_trace(fig,
                    type="scatter",
                    mode="lines",
                    x=c(0, 1, 0.5, 0),
                    y=c(1, 1, 1+dY*2/3, 1),
                    fill="toself",
                    fillcolor=PaletteColors[colors],
                    line=list(width=0),
                    text=paste0("<b>",
                                counts[colors],
                                "</b>",
                                "<br>stations"),
                    hoverinfo="text",
                    hoveron="fills",
                    hoverlabel=list(bgcolor=counts[colors],
                                    font=list(size=12),
                                    bordercolor="white"))
    
    fig = add_trace(fig,
                    type="scatter",
                    mode="lines",
                    x=c(0, 1, 0.5, 0),
                    y=c(-1, -1, -1-dY*2/3, -1),
                    fill="toself",
                    fillcolor=PaletteColors[1],
                    line=list(width=0),
                    text=paste0("<b>",
                                counts[1],
                                "</b>",
                                "<br>stations"),
                    hoverinfo="text",
                    hoveron="fills",
                    hoverlabel=list(bgcolor=counts[1],
                                    font=list(size=12),
                                    bordercolor="white"))

    Xlab = rep(1.2, colors)
    Ylab = bin / max(bin)

    ncharLim = 4
    if (type == 'sévérité') {
        labelRaw = bin*100
    } else if (type == 'saisonnalité') {
        labelRaw = bin
    }
    label2 = signif(labelRaw, 2)
    label2[label2 >= 0] = paste0(" ", label2[label2 >= 0])
    label1 = signif(labelRaw, 1)
    label1[label1 >= 0] = paste0(" ", label1[label1 >= 0])
    label = label2        
    label[nchar(label2) > ncharLim] = label1[nchar(label2) > ncharLim]
    label = paste0("<b>", label, "</b>")
    
    fig = add_annotations(fig,
                          x=Xlab,
                          y=Ylab,
                          text=label,
                          showarrow=FALSE,
                          xanchor='left',
                          font=list(color=grey40COL,
                                    size=12))

    if (type == 'sévérité') {
        title = paste0("<b>", word("cb.title"), "</b>",
                       " ", word("cb.unit.Q"))
    } else if (type == 'saisonnalité') {
        title = paste0("<b>", word("cb.title"), "</b>",
                       " ", word("cb.unit.t"))
    }
    
    fig = add_annotations(fig,
                          x=-0.1,
                          y=0,
                          text=title,
                          textangle=-90,
                          showarrow=FALSE,
                          xanchor='right',
                          yanchor='center',
                          font=list(color=grey50COL,
                                    size=13.5))
    
    fig = config(fig,
                 displaylogo=FALSE,
                 displayModeBar=FALSE,
                 doubleClick=FALSE)                
    fig  

    return(fig)
}

