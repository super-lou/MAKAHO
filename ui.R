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
    
    tags$head(HTML("<title>MAKAHO</title> <link rel='icon' type='image/gif/png' href='MAKAHO.png'>")),

    tags$head(tags$script('
    var dimension = [0, 0];
    $(document).on("shiny:connected", function(e) {
        dimension[0] = window.innerWidth;
        dimension[1] = window.innerHeight;
        Shiny.onInputChange("dimension", dimension);
    });
    $(window).resize(function(e) {
        dimension[0] = window.innerWidth;
        dimension[1] = window.innerHeight;
        Shiny.onInputChange("dimension", dimension);
    });')),
    
## 1. MAP ____________________________________________________________
### 1.1. Background __________________________________________________    
    tags$style(type="text/css",
               "html, body {width: 100%; height: 100%}"),
    tags$head(tags$style(
                       ".leaflet-control-easyPrint.leaflet-bar.leaflet-control
                   {display: none;}")),

    includeCSS("www/ui.css"),
    
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
                   div(class="Row",
                       div(Button(
                           class="SmallButton-menu",
                           'focusZoom_button',
                           NULL,
                           icon_name=iconLib$focus_white)))
                   )
    ),
    
    hidden(
        fixedPanel(id='defaultZoom_panel',
                   left=10, top=10,
                   width="auto", height="auto",
                   div(class="Row",
                       div(Button(
                           class="SmallButton-menu",
                           'defaultZoom_button',
                           NULL,
                           icon_name=iconLib$default_white)))
                   )
    ),

    
## 2. ANALYSE ________________________________________________________
### 2.1. Panel button ________________________________________________
    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               div(class="Row",
                   div(Button(class="Button-menu",
                              'ana_button',
                              HTML(paste0("<b>",
                                          word("a.title"),
                                          "</b>")),
                              icon_name=iconLib$show_chart_white)))
               ),
    
### 2.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            class="Panel card",
            fixed=TRUE,
            width=460, height="auto",
            left=10, bottom=49,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("a.data"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch", role="toolbar",
                    textOutput("data"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("a.date"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch", role="toolbar",
                    textOutput("period"))),
            
### 2.3. Station selection ___________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("a.selec"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch", role="toolbar",
                    Button(class="Button",
                           'all_button',
                           label=word("a.selec.all"),
                           icon_name=iconLib$check_circle_white),
                    
                    Button(class="Button",
                           'none_button',
                           label=word("a.selec.none"),
                           icon_name=iconLib$cross_circle_white),
                    
                    Button(class="Button",
                           'click_button',
                           label=word("a.selec.click"),
                           icon_name=iconLib$click_white),

                    # Button(class="Button",
                    #        'poly_button',
                    #        label=word("a.selec.poly"),
                    #        icon_name=iconLib$polyline_white),

                    selectButton(
                        class="Button",
                        inputId="poly_select",
                        label=word("a.selec.poly"),
                        icon_name=iconLib$polyline_white,
                        selected=FALSE),

                    selectButton(
                        class="Button",
                        inputId="warning_select",
                        label=word("a.selec.warning"),
                        icon_name=iconLib$error_outline_white,
                        selected=TRUE),

                    selectizeInput(inputId="search_input", 
                                   label=NULL,
                                   multiple=TRUE,
                                   choices=NULL)
                    )),

### 2.4. Variable selection __________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('a.event'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="Button",
                                inputId="event_choice",
                                choices=rle(Var$event)$values,
                                selected=rle(Var$event)$values[1]))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('a.var'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="Button",
                                inputId="var_choice",
                                choices=FALSE,
                                selected=NULL))),

            hidden(
                div(class="Row", id="proba_row",
                    div(class="row-label",
                        HTML(paste0("<span><b>",
                                    word('a.proba'),
                                    "</b></span>"))),
                    div(class="sep"),
                    div(class="bunch",
                        radioButton(class="Button",
                                    inputId="proba_choice",
                                    choices=FALSE,
                                    selected=NULL)))),
            
### 2.5. Period selection ____________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('a.dm'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch textSlider",
                    sliderTextInput(inputId="dateMonth_slider",
                                    label=NULL,
                                    grid=TRUE,
                                    force_edges=FALSE,
                                    choices=Months))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('a.dy'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    sliderInput("dateYear_slider",
                                label=NULL,
                                step=1,
                                sep='',
                                min=1900,
                                max=2020,
                                value=c(1968, 2020)))),

### 2.6. Statistical option ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("a.sig"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="Button",
                                inputId="alpha_choice",
                                choices=sigP,
                                selected=sigP[3])))
        )
    ),


    hidden(
        absolutePanel(
            id='click_panel',
            style=CSSpanel_center,
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,

            Button('clickOk_button', label=word("b.ok"),
                   style=CSSbutton_soloBar,
                   icon_name=iconLib$ok_black)
        )
    ),

    hidden(
        absolutePanel(
            id='poly_panel',
            style=CSSpanel_center,
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,

            Button('polyAdd_button', label=NULL,
                   style=CSSbutton_startBar,
                   icon_name=iconLib$add_black),
            
            Button('polyRm_button', label=NULL,
                   style=CSSbutton_middleBar,
                   icon_name=iconLib$remove_black),
            
            Button('polyOk_button', label=word("b.ok"),
                   style=CSSbutton_endBar,
                   icon_name=iconLib$ok_black)
        )
    ),

### 2.7. Trend plot __________________________________________________
    hidden(
        absolutePanel(
            id='plot_panel',
            style=CSSpanel_plot,
            fixed=TRUE,
            draggable=TRUE,
            width=520, height=220,
            left=0, bottom=10, right=0,
            
            tags$div(style="position: absolute;
                            margin-bottom: 10px; margin-top: 10px;
                            margin-left: 10px; margin-right: 10px;",
                     plotOutput("trend_plot")),
            
            tags$div(style="position: absolute;",
                     Button('closePlot_button', label=NULL,
                            style=CSSbutton_inPanelSmall,
                            icon_name=iconLib$close_black))
        )
    ),

    

## 3. CUSTOMIZATION __________________________________________________
### 3.1. Panel button ________________________________________________
    fixedPanel(left=116, bottom=10,
               width="auto", height="auto",
               div(class="Row",
                   div(Button(class="Button-menu",
                              'theme_button',
                              NULL,
                              icon_name=iconLib$menu_white)))
               ),
    
### 3.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='theme_panel',
            class="Panel card",
            fixed=TRUE,        
            width="auto", height="auto",
            left=116, bottom=49,
            
### 3.2. Background theme ____________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("c.theme"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(
                        class="Button",
                        inputId="theme_choice",
                        choiceNames=
                            list(paste0(img(iconLib$light_white,
                                            align="right"),
                                        'clair'),
                                 paste0(img(iconLib$terrain_white,
                                            align="right"),
                                        'terrain'),
                                 paste0(img(iconLib$dark_white,
                                            align="right"),
                                        'sombre')),
                        choiceValues=
                            list("light",
                                 "terrain",
                                 "dark")))),
            
### 3.3. Palette button ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.cb"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="Button",
                                inputId="colorbar_choice",
                                choiceNames=
                                    list(word("c.cb.show"),
                                         word("c.cb.none")),
                                choiceValues=
                                    list("show", "none"),
                                selected="none")))
            
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
               Button('info_button', label=NULL,
                      style=CSSbutton_info,
                      icon_name=iconLib$INRAElogo)
               ),
    
### 4.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            class="Panel card",
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=40,

### 4.3. Contact info ________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("i.dev"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    a(href="mailto:louis.heraut@inrae.fr",
                      "Louis Héraut"))),

            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("i.ref"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    a(href="mailto:michel.lang@inrae.fr",
                      "Michel Lang"))),

            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("i.sk8"),
                               "</b></span>"))),
                div(class="sep"),
                div(a(href="https://sk8.inrae.fr",
                      img(src="SK8.png"))),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://sk8.inrae.fr",
                      "SK8")))
        )
    ),

    
## 5. SAVE ___________________________________________________________
### 5.1. Download ____________________________________________________
    fixedPanel(right=10, top=10,
               width="auto", height="auto",
               Button('download_button',
                      style=CSSbutton_panelSmall,
                      icon_name=iconLib$download_white)
               ),

    downloadLink("downloadData", label=""),
    tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",
                                function(message) {
                                eval(message.value);});'))),
    
    hidden(
        absolutePanel(
            id='download_panel',
            style=CSSpanel_center,
            fixed=TRUE,
            width=200, height="auto",
            left=0, top=10, right=0,
            Button('downloadOk_button', label=word("b.ok"),
                   style=CSSbutton_soloBar,
                   icon_name=iconLib$ok_black)
        )
    ),
    
### 5.2. Screenshot __________________________________________________
    fixedPanel(right=50, top=10,
               width="auto", height="auto",
               Button('photo_button',
                      style=CSSbutton_panelSmall,
                      icon_name=iconLib$photo_white)
               ),
    
    )
