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
# ui.R


ui = bootstrapPage(

    useShinyjs(),

    
## 1. MAP ____________________________________________________________
### 1.1. Background __________________________________________________    
    tags$style(type="text/css",
               "html, body {width:100%;height:100%}"),
    
    tags$body(leafletOutput("map", width="100%", height="100%")),

    tags$par(leafletOutput("mapPreview", width="100%", height="100%")),

### 1.2. Zoom ________________________________________________________
    hidden(
        fixedPanel(id='focusZoom_panel',
                   left=10, top=10,
                   width="auto", height="auto",
                   actionButtonI('focusZoom_button',
                                 style=smallButtonCSS,
                                 icon_name=iconLib$focus)
                   )
    ),
    hidden(
        fixedPanel(id='defaultZoom_panel',
                   left=10, top=10,
                   width="auto", height="auto",
                   actionButtonI('defaultZoom_button',
                                 style=smallButtonCSS,
                                 icon_name=iconLib$default)
                   )
    ),

        
## 2. ANALYSE ________________________________________________________
### 2.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            style=menuPanelCSS,
            fixed=TRUE,
            width=310, height="auto",
            left=10, bottom=50,
            
### 2.2. Code selection ______________________________________________
            column(9, style='padding-right: 0px; margin-right: 0px; margin-top: 9px;',
                   pickerInput(
                       inputId="code_picker",
                       label=word("a.sta"), 
                       choices=NULL,
                       multiple=TRUE,
                       selected=NULL,
                       options=list(size=7,
                                    `live-search`=TRUE,
                                    `actions-box`=TRUE))),
            
            column(2, style='margin-left: 7px; margin-top: 9px;',
                   actionButtonI('poly_button',
                                 NULL,
                                 style=polyButtonCSS,
                                 icon_name=iconLib$draw)),

            column(12,
                   selectizeInput(
                       inputId="search_input", 
                       label=NULL,
                       multiple=TRUE,
                       choices=NULL)),

### 2.3. Variable selection __________________________________________
            column(12,
                   selectInput("varName", word('a.varT'),
                               varNameList)),
            column(12, style="margin-top: -12px;",
                   hidden(
                       radioGroupButtons(inputId="proba_choice",
                                         choices=FALSE,
                                         selected=NULL))),
        
### 2.4. Period selection ____________________________________________
            chooseSliderSkin("Flat", "#00A5A8"),
            tags$style(type="text/css",
                       ".irs-grid-pol.small {height: 0px;}"),

            column(12,
                   sliderTextInput(inputId="dateMonth_slider",
                                   label=word("a.dm"),
                                   grid=TRUE,
                                   force_edges=TRUE,
                                   choices=Months)),

            column(12,
                   sliderInput("dateYear_slider", word("a.dy"),
                               step=1,
                               sep='',
                               min=1900,
                               max=as.numeric(format(today, "%Y")),
                               value=c(1968, 2020))),

### 2.5. Statistical option ______________________________________________
            column(12,
                   radioGroupButtons(inputId="signif_choice",
                                     label=word("a.sig"),
                                     size="sm",
                                     choices=sigP,
                                     selected=sigP[3])),
            
            column(12,
                   radioGroupButtons(inputId="trendArea_choice",
                                     label=word("a.ctT"),
                                     size="sm",
                                     choices=c(word("a.cts"), word("a.ctr")),
                                     selected=word("a.cts")))
        )
    ),
    
### 2.6. Panel button ________________________________________________
    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('ana_button',
                            HTML(paste0("<b>", word("a.title"), "</b>")),
                            style=panelButtonCSS,
                            icon_name=iconLib$analytics)
               ),


## 3. CUSTOMIZATION __________________________________________________
### 3.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='theme_panel',
            style=menuPanelCSS,
            fixed=TRUE,        
            width="auto", height="auto",
            left=120, bottom=50,
            
### 3.2. Background theme ____________________________________________
            column(12,
                   radioGroupButtons(inputId="theme_choice",
                                     label=word("c.theme"),
                                     size="xs",
                                     selected="light",
                                     choiceNames=
                                         list(img(iconLib$light,
                                                  align="right"),
                                              img(iconLib$terrain,
                                                  align="right"),
                                              img(iconLib$dark,
                                                  align="right")),
                                     choiceValues= list("light",
                                                        "terrain",
                                                        "dark")))
        )
    ),
    
### 3.3. Panel button ________________________________________________
    fixedPanel(left=120, bottom=10,
               width="auto", height="auto",
               actionButtonI('theme_button', label=NULL,
                             style=panelButtonCSS,
                             icon_name=iconLib$palette)
               ),

### 3.4. Polygon panel _______________________________________________
    hidden(
        absolutePanel(
            id='poly_panel',
            style="background-color: transparent; margin: auto;",
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,

            actionButtonI('polyAdd_button', label=NULL,
                          style=polyBarStartButtonCSS,
                          icon_name=iconLib$add),
            
            actionButtonI('polyRm_button', label=NULL,
                          style=polyBarButtonCSS,
                          icon_name=iconLib$remove),
            
            actionButtonI('polyOk_button', label=word("p.ok"),
                          style=polyBarEndButtonCSS,
                          icon_name=iconLib$ok)
            )
        ),

    
## 4. INFO ___________________________________________________________
### 4.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            style=infoPanelCSS,
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=40,

### 4.2. Contact info ________________________________________________
            column(12,
            tags$div(tags$b(word("i.con")),
                     tags$br(),
                     word("i.dev"),
                     tags$a(href="mailto:louis.heraut@inrae.fr",
                            "Louis Héraut"),
                     tags$br(),
                     word("i.ref"),
                     tags$a(href="mailto:michel.lang@inrae.fr",
                            "Michel Lang")))
        )
    ),
    
### 4.3. Panel button ________________________________________________ 
    fixedPanel(right=10, bottom=0,
               width="auto", height="auto",
               actionButtonI('info_button', label=NULL,
                             style=infoButtonCSS,
                             icon_name=iconLib$INRAElogo)
               ),

    
## 5. SAVE ___________________________________________________________
### 5.1. Download ____________________________________________________
    fixedPanel(right=10, top=10,
               width="auto", height="auto",
               actionButtonI('download_button',
                             style=smallButtonCSS,
                             icon_name=iconLib$download)
               ),
    
### 5.2. Screenshot __________________________________________________
    fixedPanel(right=50, top=10,
               width="auto", height="auto",
               actionButtonI('photo_button',
                             style=smallButtonCSS,
                             icon_name=iconLib$photo)
               ),
   
)
