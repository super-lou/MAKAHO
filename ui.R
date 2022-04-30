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
               "html, body {width: 100%; height: 100%}"),
    tags$head(tags$style(
               ".leaflet-control-easyPrint.leaflet-bar.leaflet-control
                   {display: none;}")),
    
    tags$body(
             
             tags$div(id='mapPreview_div',
                      style="position: absolute;
                             top: 0; bottom: 0; left: 0; right: 0;",
                      leafletOutput("mapPreview", width="100%",
                                    height="100%")),
             
             tags$div(id='map_div',
                      style="position: absolute;
                             top: 0; bottom: 0; left: 0; right: 0;",
                      leafletOutput("map", width="100%",
                                    height="100%")),
         ),

### 1.2. Zoom ________________________________________________________
    hidden(
        fixedPanel(id='focusZoom_panel',
                   left=10, top=10,
                   width="auto", height="auto",
                   actionButtonI('focusZoom_button',
                                 style=CSSbutton_small,
                                 icon_name=iconLib$focus)
                   )
    ),
    
    hidden(
        fixedPanel(id='defaultZoom_panel',
                   left=10, top=10,
                   width="auto", height="auto",
                   actionButtonI('defaultZoom_button',
                                 style=CSSbutton_small,
                                 icon_name=iconLib$default)
                   )
    ),

        
## 2. ANALYSE ________________________________________________________
### 2.1. Panel button ________________________________________________
    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('ana_button',
                            HTML(paste0("<b>", word("a.title"), "</b>")),
                            style=CSSbutton_panel,
                            icon_name=iconLib$analytics)
               ),
    
### 2.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            style=CSSpanel_left,
            fixed=TRUE,
            width=310, height="auto",
            left=10, bottom=50,
            
### 2.3. Code selection ______________________________________________
            column(7, style="padding-right: 0px; margin-right: 0px;
                             margin-top: 9px;",
                   pickerInput(
                       inputId="code_picker",
                       label=word("a.sta"), 
                       choices=NULL,
                       multiple=TRUE,
                       selected=NULL,
                       options=list(size=7,
                                    `live-search`=TRUE,
                                    `actions-box`=TRUE))),

            column(2, style="margin-left: 4px; margin-top: 34px;
                             margin-bottom: 0px;",
                   actionButtonI('click_button',
                                 NULL,
                                 style=CSSbutton_inPanel,
                                 icon_name=iconLib$click)),
            
            column(2, style="margin-left: 4px; margin-top: 34px;
                             margin-bottom: 0px;",
                   actionButtonI('poly_button',
                                 NULL,
                                 style=CSSbutton_inPanel,
                                 icon_name=iconLib$draw)),

            column(12,
                   selectizeInput(
                       inputId="search_input", 
                       label=NULL,
                       multiple=TRUE,
                       choices=NULL)),


### 2.4. Variable selection __________________________________________
            column(12,
                   selectInput("varName", word('a.varT'),
                               varNameList)),
            column(12, style="margin-top: -12px;",
                   hidden(
                       radioGroupButtons(inputId="proba_choice",
                                         choices=FALSE,
                                         selected=NULL))),
        
### 2.5. Period selection ____________________________________________
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

### 2.6. Statistical option ______________________________________________
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


    hidden(
        absolutePanel(
            id='click_panel',
            style=CSSpanel_center,
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,

            actionButtonI('clickOk_button', label=word("b.ok"),
                          style=CSSbutton_soloBar,
                          icon_name=iconLib$ok)
        )
    ),


    hidden(
        absolutePanel(
            id='poly_panel',
            style=CSSpanel_center,
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,

            actionButtonI('polyAdd_button', label=NULL,
                          style=CSSbutton_startBar,
                          icon_name=iconLib$add),
            
            actionButtonI('polyRm_button', label=NULL,
                          style=CSSbutton_middleBar,
                          icon_name=iconLib$remove),
            
            actionButtonI('polyOk_button', label=word("b.ok"),
                          style=CSSbutton_endBar,
                          icon_name=iconLib$ok)
        )
    ),


## 3. CUSTOMIZATION __________________________________________________
### 3.1. Panel button ________________________________________________
    fixedPanel(left=120, bottom=10,
               width="auto", height="auto",
               actionButtonI('theme_button', label=NULL,
                             style=CSSbutton_panel,
                             icon_name=iconLib$palette)
               ),
    
### 3.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='theme_panel',
            style=CSSpanel_left,
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
                                                        "dark"))),

### 3.3. Palette button ______________________________________________
            column(12, style='margin-bottom: 10px;',
                   actionButtonI('colorbar_button',
                                 label=word("c.colorbar"),
                                 style=CSSbutton_colorbar)),
            
        )
    ),

    hidden(
        absolutePanel(
            id="colorbar_panel",
            style=CSSpanel_colorbar,
            fixed=TRUE,
            width=75, height=270,
            right=0, top=0, bottom=0,
            tags$div(style="margin-bottom: 10px; margin-top: 10px;
                            margin-left: 10px; margin-right: 10px;",
                     plotOutput("colorbar_plot"))
        )
    ),

    
## 4. INFO ___________________________________________________________
### 4.1. Panel button ________________________________________________ 
    fixedPanel(right=10, bottom=0,
               width="auto", height="auto",
               actionButtonI('info_button', label=NULL,
                             style=CSSbutton_info,
                             icon_name=iconLib$INRAElogo)
               ),
    
### 4.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            style=CSSpanel_right,
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=40,

### 4.3. Contact info ________________________________________________
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

   
## 5. SAVE ___________________________________________________________
### 5.1. Download ____________________________________________________
    fixedPanel(right=10, top=10,
               width="auto", height="auto",
               actionButtonI('download_button',
                             style=CSSbutton_small,
                             icon_name=iconLib$download)
               ),
    
### 5.2. Screenshot __________________________________________________
    fixedPanel(right=50, top=10,
               width="auto", height="auto",
               actionButtonI('photo_button',
                             style=CSSbutton_small,
                             icon_name=iconLib$photo)
               ),
   
)
