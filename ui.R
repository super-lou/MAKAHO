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


## 0. META ___________________________________________________________
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
              tags$meta(property="og:description", content=gsub("<b>|</b>", "", word("help.p1.p1", lg)))),

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

    tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",
                                function(message) {
                                eval(message.value);});'))),

    
## 1. MAP ____________________________________________________________
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


## 2. FLOATING PANEL _________________________________________________
### 1.1. Palette _____________________________________________________
    hidden(
        absolutePanel(
            id="colorbar_panel",
            class="Panel card-insert-r",
            # style="transform: translate(0, 0%);",
            fixed=TRUE,
            width="auto",
            height="auto", #280
            right=0, bottom="170px",
            
            div(style="margin-top: 10px;
                       margin-bottom: 10px;
                       margin-left: 10px;
                       margin-right: 5px;",
                plotly::plotlyOutput("colorbar_plot",
                                     width="auto",
                                     height="auto"))
        )
    ),

### 1.2. Statistics __________________________________________________
    hidden(
        absolutePanel(
            id='stat_panel',
            class="Panel card-insert-r",
            # style="transform: translate(0, 100%);",
            fixed=TRUE,
            width="auto", height="auto",
            right=0, bottom="90px",
            
            div(class="card-insert-text",

                h6(class="no-margin-v",
                  style="font-size: 0.8em; color: #999999;",
                   HTML(paste0(
                       htmlOutput("stat_totalHTML")
                   )))

                )
        )
    ),

### 1.3. Resume ______________________________________________________
    hidden(
        absolutePanel(
            id='resume_panel',
            class="Panel card-insert-r",
            # style="transform: translate(0, -100%);",
            fixed=TRUE,
            width="auto", height="auto",
            right=0, top="100px",
            
            div(class="card-insert-text",
                
                h4(class="no-margin-v",
                   htmlOutput("variableHTML")),

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
                       htmlOutput("sampling_periodHTML")
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
    

## 3. HELP BACKGROUND ________________________________________________
    hidden(
        fixedPanel(id='help_panelButton',
                   right=105, bottom=10,
                   width="auto", height="auto",
                   Button(class="Button-icon-hover",
                          style="color: rgba(5, 5, 10, 0.90) !important;
                                 padding-left: 0.5rem !important;
                                 padding-right: 0.5rem !important;",
                          inputId='help_button',
                          label=word("help", lg),
                          icon_name=iconLib$help_outline,
                          tooltip=word("tt.help", lg))
                   )
    ),

    hidden(
        fixedPanel(id='blur_panel',
                   class="Panel card-blur"   
                   )
    ),
    

## 4. ZOOM ___________________________________________________________
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
                                         tooltip=word("tt.z.focus", lg))
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
                                         tooltip=word("tt.z.default", lg))
                                  )
                   )
                   )
    ),

    
## 5. ANALYSE ________________________________________________________
### 5.1. Trend plot __________________________________________________
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
            
            div(Button(class="Button-icon-hover",
                       style="position: absolute;
                              top: 0.15rem;
                              left: 0.15rem;",
                       inputId='closePlot_button',
                       label=NULL,
                       icon_name=iconLib$close_black))
        )
    ),

### 5.2. Panel button ________________________________________________
    hidden(
        fixedPanel(id='ana_panelButton',
                   left=10, bottom=10,
                   width="auto", height="auto",
                   Button(class="Button-menu",
                          inputId='ana_button',
                          label=HTML(paste0("<b>",
                                            word("ana.title", lg),
                                            "</b>")),
                          icon_name=iconLib$show_chart_white,
                          tooltip=word("tt.ana.title", lg))
                   )
    ),
    
### 5.3. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            class="Panel card-ana",
            fixed=TRUE,
            height="auto",
            left=10, bottom=49,

#### 5.3.1. customize button _________________________________________
            div(style="position: absolute;
                       bottom: 0.6rem;
                       right: 0.6rem;",
                Button(class="Button-icon-hover",
                       inputId='theme_button',
                       label=NULL,
                       icon_name=iconLib$settings_white,
                       tooltip=word("tt.c.title", lg))),

#### 5.3.2. info _____________________________________________________
            div(class="Row",
                htmlOutput("dataHTML_ana")),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.date", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    textOutput("period_ana"))),

#### 5.3.3. dataset __________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.data", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",

                    ### /!\ ###

                    # radioButton(
                    #     class="radioButton",
                    #     inputId="data_choice",
                    #     choiceNames=c("RRSE", "RRExplore2"),
                    #     selected=default_data,
                    #     choiceTooltips=
                    #         c(word("tt.ana.data.RRSE"),
                    #           word("tt.ana.data.RRExplore2"))))),

                    radioButton(
                        class="radioButton",
                        inputId="data_choice",
                        choiceNames="RRSE",
                        selected=default_data,
                        choiceTooltips=word("tt.ana.data.RRSE", lg)))),

            ######
            
            
#### 5.3.4. station __________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.selec", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    
                    Button(class="Button",
                           'all_button',
                           label=word("ana.selec.all", lg),
                           icon_name=iconLib$check_circle_white,
                           tooltip=word("tt.ana.selec.all", lg)),
                    
                    Button(class="Button",
                           'none_button',
                           label=word("ana.selec.none", lg),
                           icon_name=iconLib$cross_circle_white,
                           tooltip=word("tt.ana.selec.none", lg)),
                    
                    selectButton(
                        class="selectButton",
                        inputId="click_select",
                        label=word("ana.selec.click", lg),
                        icon_name=iconLib$click_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.selec.click", lg)),

                    selectButton(
                        class="selectButton",
                        inputId="poly_select",
                        label=word("ana.selec.poly", lg),
                        icon_name=iconLib$polyline_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.selec.poly", lg)),

                    selectButton(
                        class="selectButton",
                        inputId="warning_select",
                        label=word("ana.selec.warning", lg),
                        icon_name=iconLib$error_outline_white,
                        selected=TRUE,
                        tooltip=word("tt.ana.selec.warning", lg)),
                    
                    selectizeInput(inputId="search_input", 
                                   label=NULL,
                                   multiple=TRUE,
                                   choices=NULL),
                    )),

#### 5.3.5. variable _________________________________________________
            hidden(
                div(class="Row", id="type_row",
                    div(class="row-label",
                        HTML(paste0("<span><b>",
                                    word('ana.type', lg),
                                    "</b></span>"))),
                    div(class="sep"),
                    div(class="bunch",
                        radioButton(class="radioButton",
                                    inputId="type_choice",
                                    choices=c(word('ana.type.T', lg),
                                              word('ana.type.Q', lg),
                                              word('ana.type.P', lg)),
                                    selected=word('ana.type.Q', lg))))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                textOutput("regimeRow"),
                                # word('ana.regime', lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(
                        class="radioButton",
                        inputId="event_choice",
                        choices=default_event,
                        selected=NULL))),
            
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.var', lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="variable_choice",
                                choices=default_variable,
                                selected=NULL))),

            hidden(
                div(class="Row", id="proba_row",
                    div(class="row-label",
                        HTML(paste0("<span><b>",
                                    textOutput("probaRow"),
                                    # word('ana.proba', lg),
                                    "</b></span>"))),
                    div(class="sep"),
                    div(class="bunch",
                        radioButton(class="radioButton",
                                    inputId="proba_choice",
                                    choices=FALSE,
                                    selected=NULL)))),

#### 5.3.5. period ___________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.dm', lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    style="margin-bottom: -16px !important;",

                    div(style="margin-left: 8px !important;",
                        uiOutput("sampling_period_slider")),

                    div(selectButton(
                        class="selectButton",
                        inputId="optimalSlider_select",
                        label=word("ana.optimal.slider", lg),
                        icon_name=iconLib$auto_awesome_white,
                        selected=FALSE,
                        tooltip=word("tt.ana.optimal.slider", lg))),
                    
                    hidden(
                        div(id="sampleSlider",
                            selectButton(
                                class="selectButton",
                                inputId="sampleSlider_select",
                                label=word("ana.sample.slider", lg),
                                icon_name=iconLib$data_array_white,
                                selected=FALSE,
                                tooltip=word("tt.ana.sample.slider", lg)))
                    ),
                    
                    hidden(
                        div(id="invertSlider",
                            selectButton(
                                class="selectButton",
                                inputId="invertSlider_select",
                                label=word("ana.invert.slider", lg),
                                icon_name=iconLib$contrast_white,
                                selected=FALSE,
                                tooltip=word("tt.ana.invert.slider", lg)))
                    )
                    )),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.dy', lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    div(style="margin-left: 8px !important;",
                        uiOutput("dateYear_slider")))),

#### 5.3.6. statistical option _______________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("ana.sig", lg),
                               "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="alpha_choice",
                                choiceValues=sigVal,
                                choiceNames=sigProba,
                                choiceTooltips=
                                    paste(word("tt.ana.sig.p", lg),
                                          sigProba),
                                selected=default_alpha)))
        )
    ),

### 5.4. Click selection bar _________________________________________
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
                           label=word("bar.ok", lg),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok", lg)))),
            )
    ),

### 5.5. Poly selection bar __________________________________________
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
                                choiceNames=list(word("poly.bar.Add", lg),
                                                 word("poly.bar.Rm", lg)),
                                choiceTooltips=list(
                                    word("tt.poly.bar.Add", lg),
                                    word("tt.poly.bar.Rm", lg)),
                                selected="Add"),
                    
                    Button(class="Button",
                           'polyOk_button',
                           label=word("bar.ok", lg),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok", lg)))),
            )
    ),


## 6. ACTUALISE ______________________________________________________
    hidden(
        fixedPanel(id='actualise_panelButton',
                   left=135, bottom=11,
                   width="auto", height="auto",
                   Button(class="SmallButton-actualise",
                          inputId='actualise_button',
                          label=word("actualise.title", lg),
                          icon_name=iconLib$refresh_white,
                          tooltip=NULL)
                   )
    ),
    

## 7. CUSTOMIZATION __________________________________________________
### 7.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='theme_panel',
            class="Panel card-settings",
            style="transform: translate(0, 50%);",
            fixed=TRUE,        
            width="auto", height="auto",
            left=10, bottom="50%",

            div(Button(class="Button-icon-hover",
                       style="position: absolute;
                              top: 0.15rem;
                              left: 0.15rem;",
                       inputId='closeSettings_button',
                       label=NULL,
                       icon_name=iconLib$close_white)),

#### 7.1.1. colorbar _________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.cb", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="colorbar_choice",
                                choiceNames=
                                    list(word("c.show", lg),
                                         word("c.none", lg)),
                                choiceValues=
                                    list("show", "none"),
                                selected=default_colorbar_choice))),

#### 7.1.2. resume ___________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.resume", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="resume_choice",
                                choiceNames=
                                    list(word("c.show", lg),
                                         word("c.none", lg)),
                                choiceValues=
                                    list("show", "none"),
                                selected=default_resume_choice))),

#### 7.1.3. stat ___________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("c.stat", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    radioButton(class="radioButton",
                                inputId="stat_choice",
                                choiceNames=
                                    list(word("c.show", lg),
                                         word("c.none", lg)),
                                choiceValues=
                                    list("show", "none"),
                                selected=default_stat_choice))),

#### 7.1.4. map background theme _____________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(
                        paste0("<span><b>",
                               word("c.theme", lg),
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
                                    list(word("c.theme.light", lg),
                                         word("c.theme.terrain", lg),
                                         word("c.theme.dark", lg)),
                                choiceTooltips=
                                    list(word("tt.c.theme.light", lg),
                                         word("tt.c.theme.terrain", lg),
                                         word("tt.c.theme.dark", lg)),
                                selected=default_theme)))
        )
    ),

    
## 8. INFO ___________________________________________________________
### 8.1. Button ______________________________________________________
    fixedPanel(id="info_panelButton",
               right=10, bottom=4,
               width="auto", height="auto",
               Button(class="Button-info",
                      inputId='info_button',
                      label=NULL,
                      icon_name=iconLib$INRAElogo,
                      tooltip=word("tt.i.title", lg))
               ),
    
### 8.2. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            class="Panel card",
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=49,

#### 8.2.1. contact __________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.contact", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    a(href="mailto:contact.makaho@listes.inrae.fr",
                      "contact.makaho@listes.inrae.fr"))),
            
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.dev", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch", "Louis Héraut")),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.ref", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch", "Michel Lang")),

#### 8.2.2. dataset ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.data", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://entrepot.recherche.data.gouv.fr/dataset.xhtml?persistentId=doi:10.57745/LNBEGZ",
                      "Recherche Data Gouv",
                      target="_blank"))),
            
#### 8.2.3. source code ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.code", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://github.com/super-lou/MAKAHO",
                      img(src="github.png", height="17px"),
                      target="_blank")),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://github.com/super-lou/MAKAHO",
                      "GitHub", target="_blank"))),

#### 8.2.4. host _____________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.sk8", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://sk8.inrae.fr",
                      img(src="SK8.png", height="17px"),
                      target="_blank")),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://sk8.inrae.fr",
                      "SK8", target="_blank"))),

#### 8.2.5. inspiration ______________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.ui", lg),
                                "</b></span>"))),
                div(class="sep"),
                div("inspirée de ",
                    a(href="https://earth.nullschool.net/",
                      "earth.nullschool.net", target="_blank"))),

#### 8.2.6. maj ______________________________________________________
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.maj", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(word("i.maj.version", lg))),
            
            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.dataext", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(word("i.dataext.date", lg)))
        )
    ),

    
## 9. SCREENSHOT _____________________________________________________
    hidden(
        fixedPanel(id='photo_panelButton',
                   right=10, top=10,
                   width="auto", height="auto",
                   Button(class="SmallButton-menu",
                          inputId='photo_button',
                          label=NULL,
                          icon_name=iconLib$photo_white,
                          tooltip=word("tt.p.title", lg))
                   )
    ),
    
## 10. DOWNLOAD ______________________________________________________
        downloadLink("downloadData", label=""),
### 10.1. Button _____________________________________________________
    hidden(
        fixedPanel(id='download_data_panelButton',
                   right=90, top=10,
                   width="auto", height="auto",

                   Button(class="SmallButton-menu",
                          inputId='download_data_button',
                          label=NULL,
                          icon_name=iconLib$download_white,
                          tooltip=word("tt.d.data.title", lg))
                   )
    ),
    hidden(
        fixedPanel(id='download_sheet_panelButton',
                   right=50, top=10,
                   width="auto", height="auto",

                   Button(class="SmallButton-menu",
                          inputId='download_sheet_button',
                          label=NULL,
                          icon_name=iconLib$description_white,
                          tooltip=word("tt.d.sheet.title", lg))
                   )
    ),

### 10.2. Panel ______________________________________________________
    hidden(
        absolutePanel(
            id='download_sheet_bar',
            class="Panel card-bar-r",
            fixed=TRUE,
            width="auto", height="auto",
            right=0, top=62,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("d.dl", lg),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",

#### 10.2.1. click ___________________________________________________
                    selectButton(class="selectButton",
                                 inputId="dlClick_select",
                                 label=word("d.click", lg),
                                 icon_name=iconLib$click_white,
                                 selected=FALSE,
                                 tooltip=word("tt.d.sheet.click", lg)),

#### 10.2.2. selection _______________________________________________
                    Button(class="Button",
                           inputId="dlSelec_button",
                           label=word("d.selec", lg),
                           icon_name=iconLib$scatter_plot_white,
                           tooltip=word("tt.d.sheet.selec", lg)),

#### 10.2.3. all _____________________________________________________
                    Button(class="Button",
                           inputId="dlAll_button",
                           label=word("d.all", lg),
                           icon_name=iconLib$check_circle_white,
                           tooltip=word("tt.d.sheet.all", lg))))
        )
    ),

### 10.3. Click bar __________________________________________________
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
                           label=word("bar.ok", lg),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok", lg))))
        )
    ),


## 11. HELP CONTENT __________________________________________________
### 11.1. Button mask ________________________________________________
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
                                            word("ana.title", lg),
                                            "</b>")),
                          icon_name=iconLib$none)
                   )
    ),
    
    hidden(
        fixedPanel(id="maskActualise_panelButton",
                   left=135, bottom=11,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-actualise",
                          inputId='mask',
                          label=word("actualise.title", lg),
                          icon_name=iconLib$none)
                   )
    ),

    hidden(
        fixedPanel(id="maskInfo_panelButton",
                   right=11, bottom=5,
                   width="auto", height="auto",
                   Button(class="maskButton-info",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$noneINRAElogo)
                   )
    ),

    hidden(
        fixedPanel(id="maskPhoto_panelButton",
                   right=10, top=10,
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
        fixedPanel(id="maskDownload_data_panelButton",
                   right=90, top=10,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),

    hidden(
        fixedPanel(id="maskDownload_sheet_panelButton",
                   right=50, top=10,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),

### 11.2. Pages ______________________________________________________
#### 11.2.1. page 1 __________________________________________________
    page_circle(n=1, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p1", lg)),
    
    hidden(
        fixedPanel(id="help1_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(style="font-size: 4em;",
                      HTML(word("help.p1.s1", lg))),
                   p(HTML(word("help.p1.p1", lg)))
                   )
    ),

#### 11.2.2. page 2 __________________________________________________
    page_circle(n=2, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p2", lg)),

    hidden(
        fixedPanel(id="help2_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p2.s1", lg))),
                   h4(HTML(word("help.p2.ss1", lg))),
                   p(HTML(word("help.p2.p1", lg)))
                   )
    ),

#### 11.2.3. page 3 __________________________________________________
    page_circle(n=3, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p3", lg)),

    hidden(
        fixedPanel(id="help3_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p3.s1", lg))),
                   h4(HTML(word("help.p3.ss1", lg))),
                   p(HTML(word("help.p3.p1", lg))),
                   p(HTML(word("help.p3.p2", lg)))
                   )
    ),

#### 11.2.4. page 4 __________________________________________________
    page_circle(n=4, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p4", lg)),

    hidden(
        fixedPanel(id="help4_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p4.s1", lg))),
                   p(HTML(word("help.p4.p1", lg))),
                   p(HTML(word("help.p4.p2", lg)))
                   )
    ),

#### 11.2.5. page 5 __________________________________________________
    page_circle(n=5, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p5", lg)),

    hidden(
        fixedPanel(id="help5_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p5.s1", lg))),
                   h4(HTML(word("help.p5.ss1", lg))),
                   p(HTML(word("help.p5.p1", lg))),
                   p(HTML(word("help.p5.p2", lg))),
                   p(HTML(word("help.p5.p3", lg)))
                   )
    ),

#### 11.2.6. page 6 __________________________________________________
    page_circle(n=6, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p6", lg)),

    hidden(
        fixedPanel(id="help6_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p6.s1", lg))),
                   h4(HTML(word("help.p6.ss1", lg))),
                   p(HTML(word("help.p6.p1", lg))),
                   p(HTML(word("help.p6.p2", lg)))
                   )
    ),


#### 11.2.7. page 7 __________________________________________________
    page_circle(n=7, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p7", lg)),

    hidden(
        fixedPanel(id="help7_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p7.s1", lg))),
                   h4(HTML(word("help.p7.ss1", lg))),
                   p(HTML(word("help.p7.p1", lg))),
                   p(HTML(word("help.p7.p2", lg))),
                   p(HTML(word("help.p7.p3", lg)))
                   )
    ),

#### 11.2.8. page 8 __________________________________________________
    page_circle(n=8, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p8", lg)),

    hidden(
        fixedPanel(id="help8_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p8.s1", lg))),
                   h4(HTML(word("help.p8.ss1", lg))),
                   p(HTML(word("help.p8.p1", lg))),
                   p(HTML(word("help.p8.p2", lg)))
                   ) 
    ),

#### 11.2.9. page 9 __________________________________________________
    page_circle(n=9, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p9", lg)),
    
    hidden(
        fixedPanel(id="help9_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p9.s1", lg))),
                   h4(HTML(word("help.p9.ss1", lg))),
                   p(HTML(word("help.p9.p1", lg))),
                   h4(HTML(word("help.p9.ss2", lg))),
                   p(HTML(word("help.p9.p2", lg)))
                   )
    ),

#### 11.2.10. page 10 ________________________________________________
    page_circle(n=10, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p10", lg)),
    
    hidden(
        fixedPanel(id="help10_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p10.s1", lg))),
                   h4(HTML(word("help.p10.ss1", lg))),
                   p(HTML(word("help.p10.p1", lg))),
                   p(HTML(word("help.p10.p2", lg))),
                   h4(HTML(word("help.p10.ss2", lg))),
                   p(HTML(word("help.p10.p3", lg)))
                   )
    ),

#### 11.2.11. page 11 ________________________________________________
    page_circle(n=11, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p11", lg)),

    hidden(
        fixedPanel(id="help11_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p11.s1", lg))),
                   h4(HTML(word("help.p11.ss1", lg))),
                   p(HTML(word("help.p11.p1", lg))),
                   p(HTML(word("help.p11.p2", lg)))
                   )
    ),

#### 11.2.12. page 12 ________________________________________________
    page_circle(n=12, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p12", lg)),

    hidden(
        fixedPanel(id="help12_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",

                   h1(HTML(word("help.p12.s1", lg))),
                   h4(HTML(word("help.p12.ss1", lg))),
                   p(HTML(word("help.p12.p1", lg))),
                   h4(HTML(word("help.p12.ss2", lg))),
                   p(HTML(word("help.p12.p2", lg)))
                   )
    ),    

#### 11.2.13. page 13 ________________________________________________
    page_circle(n=13, leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p13", lg)),
    
    hidden(
        fixedPanel(id="help13_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p13.s1", lg))),
                   p(HTML(word("help.p13.p1", lg)))
                   )
    ),

#### 11.2.14. page 14 ________________________________________________
    page_circle(n=14,
                leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p14", lg)),
    
    hidden(
        fixedPanel(id="help14_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p14.s1", lg))),
                   p(HTML(word("help.p14.p1", lg))),
                   p(HTML(word("help.p14.p2", lg))),
                   p(HTML(word("help.p14.p3", lg)))
                   )
    ),

#### 11.2.15. page 15 ________________________________________________
    page_circle(n=15,
                leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p15", lg)),
    
    hidden(
        fixedPanel(id="help15_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto", height="auto",
                   
                   h1(HTML(word("help.p15.s1", lg))),
                   p(HTML(word("help.p15.p1", lg))),
                   p(HTML(word("help.p15.p2", lg)))
                   )
    ),
    
#### 11.2.16. page 16 ________________________________________________
    page_circle(n=16,
                leftBase=leftHelp,
                widthHelp=widthHelp,
                bottom=bottomNavHelp,
                dh=dhNavHelp, tooltip=word("tt.help.p16", lg)),
    
    hidden(
        fixedPanel(id="help16_panel",
                   class="Panel card-help",
                   left=leftHelp, top=topHelp,
                   width="auto",
                   height="auto",
                   
                   h1(HTML(word("help.p16.s1", lg))),
                   p(HTML(word("help.p16.p1", lg)))
                   )
    ),

### 11.3. Nave button ________________________________________________
#### 11.3.1. before __________________________________________________
    hidden(
        fixedPanel(id="before_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " - ", dhNavHelp, "px)"),
                   bottom=bottomNavHelp,
                   width="auto", height="auto",
                   Button(class="Button-icon-hover",
                          inputId='before_button',
                          label=NULL,
                          icon_name=iconLib$navigate_before_white,
                          tooltip=word("tt.help.pb", lg))
                   )
    ),

#### 11.3.2. after ___________________________________________________
    hidden(
        fixedPanel(id="next_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dhNavHelp*N_helpPage, "px)"),
                   bottom=bottomNavHelp,
                   width="auto", height="auto",
                   Button(class="Button-icon-hover",
                          inputId='next_button',
                          label=NULL,
                          icon_name=iconLib$navigate_next_white,
                          tooltip=word("tt.help.pn", lg))
                   )
    ),

#### 11.3.3. download help ___________________________________________
    hidden(
        fixedPanel(id='dlHelp_panelButton',
                   # left=paste0("calc(", leftHelp,
                   #             " - ", 0.5*widthHelp, "px",
                   #             " + ", dhNavHelp*(N_helpPage+1), "px)"),
                   # bottom=bottomNavHelp+1,
                   left=paste0("calc(", leftHelp,
                               " - 1% - 10rem)"),
                   bottom=paste0("calc(", bottomNavHelp, "px - 2rem)"),
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          style="padding-left: 0.5rem !important;
                                 padding-right: 0.5rem !important;",
                          inputId='dlHelp_button',
                          label=word("help.dl", lg),
                          icon_name=iconLib$newspaper_white,
                          tooltip=NULL) 
                   )
    ),

#### 11.3.4. close ___________________________________________________
    hidden(
        fixedPanel(id='closeHelp_panelButton',
                   left=paste0("calc(", leftHelp,
                               " - 1% + 2.5rem)"),
                   bottom=paste0("calc(", bottomNavHelp, "px - 2rem)"), 
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          style="padding-left: 0.5rem !important;
                                 padding-right: 0.5rem !important;",
                          inputId='closeHelp_button',
                          label=word("help.close", lg),
                          icon_name=iconLib$close_white,
                          tooltip=NULL)
                       )
        ),

## 12. LOADING SYMBOL ________________________________________________
    hidden(
        fixedPanel(id='loading_panel',
                   class="card-load",
                   left=0, top=0,
                   width="100%", height="100%",
                   
                   div(style="position: fixed;
                              left: 135px; bottom: 11px;",
                       HTML('<div class="lds-ring"><div></div><div></div><div></div><div></div></div>'))
                   )
    )
)
