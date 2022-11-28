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
                        });
                        ')),

    useShinyjs(),
    
    tags$head(HTML("<title>MAKAHO</title> <link rel='icon' type='image/gif/png' href='MAKAHO.png'>")),

    tags$head(tags$meta(property="og:title", content="MAKAHO"),
              tags$meta(property="og:image", content="https://forgemia.inra.fr/sk8/sk8-apps/ara/riverly/makaho/-/raw/main/www/screen.png"),
              tags$meta(property="og:description", content=gsub("<b>|</b>", "", word("help.p1.p1")))),

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
             
             div(id='mapPreview_div',
                 style="position: absolute;
                             top: 0; bottom: 0; left: 0; right: 0;",
                 leafletOutput("mapPreview", width="100%",
                                    height="100%")),
             
             div(id='map_div',
                 style="position: absolute;
                             top: 0; bottom: 0; left: 0; right: 0;",
                 leafletOutput("map", width="100%",
                               height="100%")),
             ),


### 3.5. Palette panel _______________________________________________
    hidden(
        absolutePanel(
            id="colorbar_panel",
            class="Panel card-insert-r",
            style="transform: translate(0, 50%);",
            fixed=TRUE,
            width="auto",
            height="auto", #280
            right=0, bottom="35%",
            
            div(style="margin-top: 10px;
                       margin-bottom: 10px;
                       margin-left: 10px;
                       margin-right: 5px;",
                plotly::plotlyOutput("colorbar_plot",
                                     width="auto",
                                     height="auto"))
        )
    ),

### 3.6. Resume panel ________________________________________________
    hidden(
        absolutePanel(
            id='resume_panel',
            class="Panel card-insert-r",
            style="transform: translate(0, -50%);",
            fixed=TRUE,
            width="auto", height="auto",
            right=0, top="30%",
            
            div(class="card-insert-text",
                
                h4(class="no-margin-v",
                   htmlOutput("varHTML")),

                hr(style="margin-top: 0.1rem;
                          margin-bottom: 0.1rem;
                          border-top: 2px solid #00a3a6;"),
                
                h6(class="no-margin-v", style="font-size: 0.8em;",
                   HTML(paste0(
                       "<b>", htmlOutput("nameHTML"), "</b>"
                   ))),

                hr(style="margin-top: 0.1rem;
                          margin-bottom: 0.1rem;
                          border-top: 2px solid #00a3a6;"),

                h6(class="no-margin-v", style="font-size: 0.8em;",
                   HTML(paste0(
                       htmlOutput("samplePeriodHTML")
                   ))),
                
                h6(class="no-margin-v", style="font-size: 0.8em;",
                   HTML(paste0(
                       textOutput("period")
                   ))),
                
                h6(class="no-margin-v", style="font-size: 0.8em;",
                   HTML(paste0(
                       textOutput("significativite")
                   )))
                )
        )
    ),
    

## 6. HELP ___________________________________________________________
    hidden(
        fixedPanel(id='help_panelButton',
                   right=105, bottom=10,
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='help_button',
                          label=NULL,
                          icon_name=iconLib$help_outline_grey,
                          tooltip=word("tt.help"))
                   )
    ),
    
    hidden(
        fixedPanel(id='blur_panel',
                   class="Panel card-blur"   
        )
    ),
    

### 1.2. Zoom ________________________________________________________
    hidden(
        fixedPanel(id="zoom_panelButton",
            hidden(
                fixedPanel(id='focusZoom_panelButton',
                           left=10, top=10,
                           width="auto", height="auto",
                           Button(class="SmallButton-menu",
                                  inputId='focusZoom_button',
                                  label=NULL,
                                  icon_name=iconLib$focus_white,
                                  tooltip=word("tt.z.focus"))
                           )
            ),
            
            hidden(
                fixedPanel(id='defaultZoom_panelButton',
                           left=10, top=10,
                           width="auto", height="auto",
                           Button(class="SmallButton-menu",
                                  inputId='defaultZoom_button',
                                  label=NULL,
                                  icon_name=iconLib$default_white,
                                  tooltip=word("tt.z.default"))
                           )
            )
        )
    ),

    
## 2. ANALYSE ________________________________________________________
### 2.7. Trend plot __________________________________________________
    hidden(
        absolutePanel(
            id='plot_panel',
            class="Panel card-insert-c",
            fixed=TRUE,
            width="auto",
            height="auto",
            bottom=10,
            
            div(style="margin: 10px;",
                plotly::plotlyOutput("trend_plot",
                                     width="auto",
                                     height="auto")),
            
            div(Button(class="Button-icon",
                       style="position: absolute;
                              top: 0.15rem;
                              left: 0.15rem;",
                       inputId='closePlot_button',
                       label=NULL,
                       icon_name=iconLib$close_black)),
            
            div(Button(class="Button-icon",
                       style="position: absolute;
                              top: 26%;
                              height: 85px;
                              left: 15px; 
                              width: 28px;
                              transform: translate(0, -50%);",
                       inputId='downloadData_button',
                       label=NULL,
                       icon_name=NULL)),
            
            div(Button(class="Button-icon",
                       style="position: absolute;
                              top: 63.5%; 
                              height: 115px;
                              left: 15px; 
                              width: 28px;
                              transform: translate(0, -50%);",
                       inputId='downloadDataEx_button',
                       label=NULL,
                       icon_name=NULL))
        )
    ),

### 2.1. Panel button ________________________________________________
    hidden(
        fixedPanel(id='ana_panelButton',
                   left=10, bottom=10,
                   width="auto", height="auto",
                   Button(class="Button-menu",
                      inputId='ana_button',
                      label=HTML(paste0("<b>",
                                        word("ana.title"),
                                        "</b>")),
                      icon_name=iconLib$show_chart_white,
                      tooltip=word("tt.ana.title"))
                   )
    ),
    
### 2.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            class="Panel card-ana",
            fixed=TRUE,
            height="auto",
            left=10, bottom=49,

### 3.1. Panel button ________________________________________________
            div(style="position: absolute;
                       bottom: 0.6rem;
                       right: 0.6rem;",
                Button(class="Button-icon",
                       inputId='theme_button',
                       label=NULL,
                       icon_name=iconLib$settings_white,
                       tooltip=word("tt.c.title"))),

### 2.2. Panel _______________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.data"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    htmlOutput("dataHTML_ana"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.date"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    textOutput("period_ana"))),
            
### 2.3. Station selection ___________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.selec"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    
                    Button(class="Button",
                           'all_button',
                           label=word("ana.selec.all"),
                           icon_name=iconLib$check_circle_white,
                           tooltip=word("tt.ana.selec.all")),
                    
                    Button(class="Button",
                           'none_button',
                           label=word("ana.selec.none"),
                           icon_name=iconLib$cross_circle_white,
                           tooltip=word("tt.ana.selec.none")),
                    
                    selectButton(
                        class="selectButton",
                        inputId="click_select",
                        label=word("ana.selec.click"),
                        icon_name=iconLib$click_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.selec.click")),

                    selectButton(
                        class="selectButton",
                        inputId="poly_select",
                        label=word("ana.selec.poly"),
                        icon_name=iconLib$polyline_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.selec.poly")),

                    selectButton(
                        class="selectButton",
                        inputId="warning_select",
                        label=word("ana.selec.warning"),
                        icon_name=iconLib$error_outline_white,
                        selected=TRUE,
                        tooltip=word("tt.ana.selec.warning")),
  
                    selectizeInput(inputId="search_input", 
                                   label=NULL,
                                   multiple=TRUE,
                                   choices=NULL),
                    )),

### 2.4. Variable selection __________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.regime'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(
                        class="radioButton",
                        inputId="event_choice",
                        choiceNames=rle(Var$event)$values,
                        selected=rle(Var$event)$values[1],
                        choiceTooltips=
                            paste(word("tt.ana.regime"),
                                  tolower(rle(Var$event)$values))))),
            
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.var'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="var_choice",
                                choices=FALSE,
                                selected=NULL))),

            hidden(
                div(class="Row", id="proba_row",
                    div(class="row-label",
                        HTML(paste0("<span><b>",
                                    word('ana.proba'),
                                    "</b></span>"))),
                    div(class="sep"),
                    div(class="bunch",
                        radioButton(class="radioButton",
                                    inputId="proba_choice",
                                    choices=FALSE,
                                    selected=NULL)))),

### 2.5. Period selection ____________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.dm'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    style="margin-bottom: -16px !important;",

                    div(style="margin-left: 8px !important;",
                        uiOutput("samplePeriod_slider")),

                    div(selectButton(
                        class="selectButton",
                        inputId="optimalSlider_select",
                        label=word("ana.optimal.slider"),
                        icon_name=iconLib$auto_awesome_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.optimal.slider"))),
                    
                    hidden(
                        div(id="sampleSlider",
                            selectButton(
                                class="selectButton",
                                inputId="sampleSlider_select",
                                label=word("ana.sample.slider"),
                                icon_name=iconLib$data_array_white,
                                selected=FALSE,
                                tooltip=word("tt.ana.sample.slider")))
                    ),
                    
                    hidden(
                        div(id="invertSlider",
                            selectButton(
                                class="selectButton",
                                inputId="invertSlider_select",
                                label=word("ana.invert.slider"),
                                icon_name=iconLib$contrast_white,
                                selected=FALSE,
                                tooltip=word("tt.ana.invert.slider")))
                    )
                    )),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.dy'),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    div(style="margin-left: 8px !important;",
                        uiOutput("dateYear_slider")))),

### 2.6. Statistical option ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("ana.sig"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="alpha_choice",
                                choiceValues=sigVal,
                                choiceNames=sigProba,
                                choiceTooltips=
                                    paste(word("tt.ana.sig.p"),
                                          sigProba),
                                selected=sigVal[3])))
        )
    ),

#### 2.3.1. Click bar ________________________________________________
    hidden(
        absolutePanel(
            id='click_bar',
            class="Panel card-smallbar-l",
            fixed=TRUE,        
            width="auto", height="auto",
            left=0, top=62,

            div(class="Row",
                div(class="bunch",
                    Button(class="Button",
                           'clickOk_button',
                           label=word("bar.ok"),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok")))),
            )
     ),

#### 2.3.2. Poly bar _________________________________________________
     hidden(
        absolutePanel(
            id='poly_bar',
            class="Panel card-bar-l",
            fixed=TRUE,        
            width="auto", height="auto",
            left=0, top=62,

            div(class="Row",
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="poly_choice",
                                choiceValues=list("Add",
                                                  "Rm"),
                                choiceIcons=list(iconLib$add_white,
                                                 iconLib$remove_white),
                                choiceNames=list(word("poly.bar.Add"),
                                                 word("poly.bar.Rm")),
                                choiceTooltips=list(word("tt.poly.bar.Add"),
                                                    word("tt.poly.bar.Rm")),
                                selected="Add"),
                    
                    Button(class="Button",
                           'polyOk_button',
                           label=word("bar.ok"),
                           icon_name=iconLib$done_white,
                       tooltip=word("tt.bar.ok")))),
            )
     ),


### 2.7. Actualise button ____________________________________________
    hidden(
        fixedPanel(id='actualise_panelButton',
                   left=124, bottom=11,
                   width="auto", height="auto",
                   Button(class="SmallButton-actualise",
                      inputId='actualise_button',
                      label=NULL,
                      icon_name=iconLib$refresh_white,
                      tooltip=word("tt.actualise.title"))
                   )
    ),
    

## 3. CUSTOMIZATION __________________________________________________
### 3.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='theme_panel',
            class="Panel card-settings",
            style="transform: translate(0, 50%);",
            fixed=TRUE,        
            width="auto", height="auto",
            left=10, bottom="50%",

            div(Button(class="Button-icon",
                       style="position: absolute;
                              top: 0.15rem;
                              left: 0.15rem;",
                       inputId='closeSettings_button',
                       label=NULL,
                       icon_name=iconLib$close_white)),

### 3.3. Palette button ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.cb"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="colorbar_choice",
                                choiceNames=
                                    list(word("c.show"),
                                         word("c.none")),
                                choiceValues=
                                    list("show", "none"),
                                selected="show"))),

### 3.4. Resume button ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.resume"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="resume_choice",
                                choiceNames=
                                    list(word("c.show"),
                                         word("c.none")),
                                choiceValues=
                                    list("show", "none"),
                                selected="show"))),

### 3.2. Background theme ____________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("c.theme"),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="theme_choice",
                                choiceValues=list("light",
                                                  "terrain",
                                                  "dark"),
                                choiceIcons=
                                    list(iconLib$light_white,
                                         iconLib$terrain_white,
                                         iconLib$dark_white),
                                choiceNames=
                                    list(word("c.theme.light"),
                                         word("c.theme.terrain"),
                                         word("c.theme.dark")),
                                choiceTooltips=
                                    list(word("tt.c.theme.light"),
                                         word("tt.c.theme.terrain"),
                                         word("tt.c.theme.dark")))))
            )
    ),

    
## 4. INFO ___________________________________________________________
### 4.1. Panel button ________________________________________________ 
    fixedPanel(id="info_panelButton",
               right=10, bottom=4,
               width="auto", height="auto",
               Button(class="Button-info",
                      inputId='info_button',
                      label=NULL,
                      icon_name=iconLib$INRAElogo,
                      tooltip=word("tt.i.title"))
               ),
    
### 4.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            class="Panel card",
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=49,

### 4.3. Contact info ________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.dev"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    a(href="mailto:louis.heraut@inrae.fr",
                      "Louis Héraut"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.ref"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    a(href="mailto:michel.lang@inrae.fr",
                      "Michel Lang"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.code"),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://github.com/super-lou/MAKAHO",
                      img(src="github.png", height="17px"),
                      target="_blank")),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://github.com/super-lou/MAKAHO",
                      "GitHub", target="_blank"))),

            
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.sk8"),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://sk8.inrae.fr",
                      img(src="SK8.png", height="17px"),
                      target="_blank")),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://sk8.inrae.fr",
                      "SK8", target="_blank"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.ui"),
                                "</b></span>"))),
                div(class="sep"),
                div("inspirée de ",
                    a(href="https://earth.nullschool.net/",
                      "earth.nullschool.net", target="_blank"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.maj"),
                                "</b></span>"))),
                div(class="sep"),
                div(word("i.maj.version")))
        )
    ),

    
## 5. SAVE ___________________________________________________________
### 5.1. Screenshot __________________________________________________
    hidden(
        fixedPanel(id='photo_panelButton',
                   right=45, top=10,
                   width="auto", height="auto",
                   Button(class="SmallButton-menu",
                          inputId='photo_button',
                          label=NULL,
                          icon_name=iconLib$photo_white,
                          tooltip=word("tt.p.title"))
                   )
    ),
    
### 5.2. Download ____________________________________________________
    hidden(
        fixedPanel(id='download_panelButton',
                   right=10, top=10,
                   width="auto", height="auto",
                   Button(class="SmallButton-menu",
                          inputId='download_button',
                          label=NULL,
                          icon_name=iconLib$download_white,
                          tooltip=word("tt.d.title"))
                   )
    ),

    downloadLink("downloadData", label=""),
    tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",
                                function(message) {
                                eval(message.value);});'))),

    hidden(
        absolutePanel(
            id='download_bar',
            class="Panel card-bar-r",
            fixed=TRUE,
            width="auto", height="auto",
            right=0, top=62,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("d.dl"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",

                    selectButton(class="selectButton",
                                 inputId="dlClick_select",
                                 label=word("d.click"),
                                 icon_name=iconLib$click_white,
                                 selected=FALSE,
                                 tooltip=word("tt.d.click")),

                    Button(class="Button",
                           inputId="dlSelec_button",
                           label=word("d.selec"),
                           icon_name=iconLib$scatter_plot_white,
                           tooltip=word("tt.d.selec")),

                    Button(class="Button",
                           inputId="dlAll_button",
                           label=word("d.all"),
                           icon_name=iconLib$check_circle_white,
                           tooltip=word("tt.d.all"))))
        )
    ),

    hidden(
        absolutePanel(
            id='dlClick_bar',
            class="Panel card-smallbar-r",
            fixed=TRUE, 
            width="auto", height="auto",
            right=0, top=62,

            div(class="Row",
                div(class="bunch",
                    Button(class="Button",
                           'dlClickOk_button',
                           label=word("bar.ok"),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok"))))
        )
    ),


## 6. HELP ___________________________________________________________
### 6.2. Button mask ________________________________________________
    hidden(
        fixedPanel(id='maskZoom_panelButton',
                   left=10, top=10,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),
    
    hidden(
        fixedPanel(id='maskAna_panelButton',
                   left=10, bottom=10,
                   width="auto", height="auto",
                   Button(class="maskButton-menu",
                          inputId='mask',
                          label=HTML(paste0("<b>",
                                            word("ana.title"),
                                            "</b>")),
                          icon_name=iconLib$none)
                   )
    ),
    
    hidden(
        fixedPanel(id="maskActualise_panelButton",
                   left=124, bottom=11,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-actualise",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),

    hidden(
        fixedPanel(id="maskInfo_panelButton",
                   right=10, bottom=4,
                   width="auto", height="auto",
                   Button(class="maskButton-info",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$noneINRAElogo)
                   )
    ),

    hidden(
        fixedPanel(id="maskPhoto_panelButton",
                   right=45, top=10,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),
    hidden(
        fixedPanel(id="opacPhoto_panelButton",
                   class="card-opac",
                   right=40, top=5,
                   width=35, height=35)
    ),

    hidden(
        fixedPanel(id="maskDownload_panelButton",
                   right=10, top=10,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
               )
    ),

### 6.3. Pages _______________________________________________________
#### 6.3.1. Page 1 ___________________________________________________
    page_circle(n=1, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p1")),
    
    hidden(
        fixedPanel(id="help1_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(style="font-size: 4em;",
                      HTML(word("help.p1.s1"))),
                   p(HTML(word("help.p1.p1")))
                   )
    ),

#### 6.3.2. Page 2 ___________________________________________________
    page_circle(n=2, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p2")),

    hidden(
        fixedPanel(id="help2_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p2.s1"))),
                   h4(HTML(word("help.p2.ss1"))),
                   p(HTML(word("help.p2.p1")))
                   )
    ),
    
#### 6.3.3. Page 3 ___________________________________________________
    page_circle(n=3, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p3")),

    hidden(
        fixedPanel(id="help3_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p3.s1"))),
                   h4(HTML(word("help.p3.ss1"))),
                   p(HTML(word("help.p3.p1"))),
                   p(HTML(word("help.p3.p2")))
                   )  
    ),
    
#### 6.3.4. Page 4 ___________________________________________________
    page_circle(n=4, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p4")),

    hidden(
        fixedPanel(id="help4_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p4.s1"))),
                   p(HTML(word("help.p4.p1"))),
                   p(HTML(word("help.p4.p2")))
                   )
    ),

#### 6.3.5. Page 5 ___________________________________________________
    page_circle(n=5, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p5")),

    hidden(
        fixedPanel(id="help5_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p5.s1"))),
                   h4(HTML(word("help.p5.ss1"))),
                   p(HTML(word("help.p5.p1"))),
                   p(HTML(word("help.p5.p2"))),
                   p(HTML(word("help.p5.p3")))
                   )
    ),
    
#### 6.3.6. Page 6 ___________________________________________________
    page_circle(n=6, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p6")),

    hidden(
        fixedPanel(id="help6_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p6.s1"))),
                   h4(HTML(word("help.p6.ss1"))),
                   p(HTML(word("help.p6.p1"))),
                   p(HTML(word("help.p6.p2")))
                   )
    ),

    
#### 6.3.7. Page 7 ___________________________________________________
    page_circle(n=7, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p7")),

    hidden(
        fixedPanel(id="help7_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p7.s1"))),
                   h4(HTML(word("help.p7.ss1"))),
                   p(HTML(word("help.p7.p1"))),
                   p(HTML(word("help.p7.p2"))),
                   p(HTML(word("help.p7.p3")))
                   )
    ),

#### 6.3.8. Page 8 ___________________________________________________
    page_circle(n=8, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p8")),

    hidden(
        fixedPanel(id="help8_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p8.s1"))),
                   h4(HTML(word("help.p8.ss1"))),
                   p(HTML(word("help.p8.p1"))),
                   p(HTML(word("help.p8.p2")))
                   ) 
    ),

#### 6.3.9. Page 9 ___________________________________________________
    page_circle(n=9, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p9")),
    
    hidden(
        fixedPanel(id="help9_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p9.s1"))),
                   h4(HTML(word("help.p9.ss1"))),
                   p(HTML(word("help.p9.p1"))),
                   h4(HTML(word("help.p9.ss2"))),
                   p(HTML(word("help.p9.p2")))
                   )
    ),

#### 6.3.10. Page 10 ___________________________________________________
    page_circle(n=10, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p10")),
    
    hidden(
        fixedPanel(id="help10_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p10.s1"))),
                   h4(HTML(word("help.p10.ss1"))),
                   p(HTML(word("help.p10.p1"))),
                   h4(HTML(word("help.p10.ss2"))),
                   p(HTML(word("help.p10.p2")))
                   )
    ),

#### 6.3.11. Page 11 _________________________________________________
    page_circle(n=11, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p11")),

    hidden(
        fixedPanel(id="help11_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p11.s1"))),
                   h4(HTML(word("help.p11.ss1"))),
                   p(HTML(word("help.p11.p1"))),
                   p(HTML(word("help.p11.p2")))
                   )
    ),

#### 6.3.12. Page 12 _________________________________________________
    page_circle(n=12, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p12")),

    hidden(
        fixedPanel(id="help12_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",

                   h1(HTML(word("help.p12.s1"))),
                   h4(HTML(word("help.p12.ss1"))),
                   p(HTML(word("help.p12.p1"))),
                   h4(HTML(word("help.p12.ss2"))),
                   p(HTML(word("help.p12.p2")))
                   )
    ),    

#### 6.3.13. Page 13 _________________________________________________
    page_circle(n=13, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p13")),
    
    hidden(
        fixedPanel(id="help13_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p13.s1"))),
                   p(HTML(word("help.p13.p1")))
                   )
    ),

#### 6.3.14. Page 14 _________________________________________________
    page_circle(n=14, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p14")),
    
    hidden(
        fixedPanel(id="help14_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p14.s1"))),
                   p(HTML(word("help.p14.p1"))),
                   p(HTML(word("help.p14.p2"))),
                   p(HTML(word("help.p14.p3")))
                   )
    ),

#### 6.3.15. Page 15 _________________________________________________
    page_circle(n=15,
                leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p15")),
    
    hidden(
        fixedPanel(id="help15_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width="auto",
                   height="auto",
                   
                   h1(HTML(word("help.p15.s1"))),
                   p(HTML(word("help.p15.p1")))
                   )
        ),

#### 6.4. Nave button ______________________________________________
    hidden(
        fixedPanel(id="before_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " - ", dhNavHelp, "px)"),
                   bottom=bottomNavHelp,
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='before_button',
                          label=NULL,
                          icon_name=iconLib$navigate_before_white,
                          tooltip=word("tt.help.pb"))
                   )
    ),


    hidden(
        fixedPanel(id="next_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dhNavHelp*N_helpPage, "px)"),
                   bottom=bottomNavHelp,
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='next_button',
                          label=NULL,
                          icon_name=iconLib$navigate_next_white,
                          tooltip=word("tt.help.pn"))
                   )
    ),

    hidden(
        fixedPanel(id='closeHelp_panelButton',
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dhNavHelp*(N_helpPage+1), "px)"),
                   bottom=bottomNavHelp,
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='closeHelp_button',
                          label=NULL,
                          icon_name=iconLib$close_white,
                          tooltip=word("tt.help.close")) 
                   )
    ),

    hidden(
        fixedPanel(id='dlHelp_panelButton',
                   left=paste0("calc(", leftHelp,
                               " - 1% - 0.5rem)"),
                   bottom=paste0("calc(", bottomNavHelp, "px - 2rem)"), 
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          style="padding-left: 0.5rem !important;
                                 padding-right: 0.5rem !important;",
                          inputId='dlHelp_button',
                          label=word("help.dl"),
                          icon_name=iconLib$newspaper_white,
                          tooltip=NULL) 
                   )
    ),



    hidden(
        fixedPanel(id='loading_panel',
                   class="card-load",
                   left=0, top=0,
                   width="100%", height="100%",
                   
                   div(style="position: fixed;
                              left: 123px; bottom: 11px;",
                       HTML('<div class="lds-ring"><div></div><div></div><div></div><div></div></div>'))
                   )
    )

)
