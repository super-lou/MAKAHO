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


## 6. HELP ___________________________________________________________
    hidden(
        fixedPanel(id='help_panelButton',
                   right=95, bottom=8,
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
    ),

    
## 2. ANALYSE ________________________________________________________
### 2.1. Panel button ________________________________________________
    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               Button(class="Button-menu",
                      inputId='ana_button',
                      label=HTML(paste0("<b>",
                                        word("ana.title"),
                                        "</b>")),
                      icon_name=iconLib$show_chart_white,
                      tooltip=word("tt.ana.title"))
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
                                word("ana.data"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    textOutput("data"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("ana.date"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    textOutput("period"))),
            
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
                div(class="bunch textSlider",
                    sliderTextInput(inputId="dateMonth_slider",
                                    label=NULL,
                                    grid=TRUE,
                                    force_edges=FALSE,
                                    choices=Months))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word('ana.dy'),
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
            class="Panel smallCard",
            fixed=TRUE,        
            width="auto", height="auto",
            left=46, top=8,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("click.bar"),
                                "</b></span>"))),
                div(class="sep"),
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
            class="Panel smallCard",
            fixed=TRUE,        
            width="auto", height="auto",
            left=46, top=8,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("poly.bar"),
                                "</b></span>"))),
                div(class="sep"),
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

### 2.7. Trend plot __________________________________________________
    hidden(
        absolutePanel(
            id='plot_panel',
            style=CSSpanel_plot,
            fixed=TRUE,
            draggable=TRUE,
            width=520, height=220,
            left=0, bottom=10, right=0,
            
            div(style="position: absolute;
                            margin-bottom: 10px; margin-top: 10px;
                            margin-left: 10px; margin-right: 10px;",
                plotOutput("trend_plot")),
            
            div(Button(class="Button-icon",
                       style="position: absolute;
                              top: 0.15rem;
                              left: 0.15rem;",
                       inputId='closePlot_button',
                       label=NULL,
                       icon_name=iconLib$close_black))
        )
    ),

    

## 3. CUSTOMIZATION __________________________________________________
### 3.1. Panel button ________________________________________________
    fixedPanel(left=116, bottom=10,
               width="auto", height="auto",
               Button(class="Button-menu",
                      inputId='theme_button',
                      label=NULL,
                      icon_name=iconLib$menu_white,
                      tooltip=word("tt.c.title"))
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
                                         word("tt.c.theme.dark"))))),
            
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
    fixedPanel(right=10, bottom=2,
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
            right=10, bottom=40,

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
                                word("i.sk8"),
                                "</b></span>"))),
                div(class="sep"),
                div(a(href="https://sk8.inrae.fr",
                      img(src="SK8.png", height="17px"))),
                div(style="padding-top: 3px; padding-left: 5px;",
                    a(href="https://sk8.inrae.fr",
                      "SK8"))),

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("i.ui"),
                                "</b></span>"))),
                div(class="sep"),
                div("inspirée de ",
                    a(href="https://earth.nullschool.net/",
                      "earth.nullschool.net")))
        )
    ),

    
## 5. SAVE ___________________________________________________________
### 5.1. Screenshot __________________________________________________
    fixedPanel(right=10, top=10,
               width="auto", height="auto",
               Button(class="SmallButton-menu",
                      inputId='photo_button',
                      label=NULL,
                      icon_name=iconLib$photo_white,
                      tooltip=word("tt.p.title"))
               ),

    hidden(
        absolutePanel(
            id='photo_panel',
            class="Panel card",
            fixed=TRUE, 
            width="auto", height="auto",
            right=45, top=10,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("p.format"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",

                    Button(class="Button",
                           inputId="photoA4l_button",
                           label=word("p.format.A4l"),
                           icon_name=iconLib$crop_landscape_white,
                           tooltip=word("tt.p.format.A4l")),

                    Button(class="Button",
                           inputId="photoA4p_button",
                           label=word("p.format.A4p"),
                           icon_name=iconLib$crop_landscape_white,
                           tooltip=word("tt.p.format.A4p"))))
        )
    ),
    
### 5.2. Download ____________________________________________________
    fixedPanel(right=10, top=45,
               width="auto", height="auto",
               Button(class="SmallButton-menu",
                      inputId='download_button',
                      label=NULL,
                      icon_name=iconLib$download_white,
                      tooltip=word("tt.d.title"))
               ),

    downloadLink("downloadData", label=""),
    tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",
                                function(message) {
                                eval(message.value);});'))),

    hidden(
        absolutePanel(
            id='download_panel',
            class="Panel card",
            fixed=TRUE,
            width="auto", height="auto",
            right=45, top=45,

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
            class="Panel smallCard",
            fixed=TRUE, 
            width="auto", height="auto",
            left=46, top=8,

            div(class="Row",
                div(class="row-label",
                    HTML(paste0("<span><b>",
                                word("dl.bar"),
                                "</b></span>"))),
                div(class="sep"),
                div(class="bunch",
                    Button(class="Button",
                           'dlClickOk_button',
                           label=word("bar.ok"),
                           icon_name=iconLib$done_white,
                           tooltip=word("tt.bar.ok"))))
        )
    ),




## 6. HELP ___________________________________________________________
### 6.2. Opaque panel ________________________________________________



    # /!\ À REPRENDRE POUR CHAQUE BOUTON AVEC LE MASK

    
    # hidden( 
    #     fixedPanel(id='opaque_panel',
    #                class="Panel card-opaque"   
    #                )
    # ),

### 6.3. Button mask ________________________________________________
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
        fixedPanel(id="maskTheme_panelButton",
                   left=116, bottom=10,
                   width="auto", height="auto",
                   Button(class="maskButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
                   )
    ),

    hidden(
        fixedPanel(id="maskInfo_panelButton",
                   right=10, bottom=2,
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
        fixedPanel(id="maskDownload_panelButton",
                   right=10, top=45,
                   width="auto", height="auto",
                   Button(class="maskSmallButton-menu",
                          inputId='mask',
                          label=NULL,
                          icon_name=iconLib$none)
               )
    ),

### 6.4. Pages _______________________________________________________
#### 6.4.1. Page 1 ___________________________________________________
    page_circle(n=1, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help1_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(style="font-size: 4em;",
                      HTML(
                       "<b>MAKAHO</b>"
                   )),
                   
                   p(HTML(
                       "MAKAHO (pour MAnn-Kendall Analysis of Hydrological Observations) est un système de <b>visualisation cartographique interactif</b> permettant d’examiner les <b>tendances</b> présentes dans les données des <b>stations hydrométriques aux débits peu influencés</b> par les actions humaines. Le test de <b>Mann-Kendall</b> permet d’analyser la significativité des tendances de variables hydrologiques sur les différentes composantes du régime des cours d'eau (étiages, moyennes-eaux, crues), à mettre ensuite en relation avec les impacts du <b>changement climatique</b> sur l’hydrologie de surface."
                   ))
                   )
    ),

#### 6.4.2. Page 2 ___________________________________________________
    page_circle(n=2, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help2_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>FOND DE CARTE</b>"
                   )),

                   h4(HTML(
                       "<b>STRUCTURE</b>"
                   )),
                   
                   p(HTML(
                       "L’interface de MAKAHO se concentre autour d’une <b>carte Leaflet interactive</b>. Le planisphère est recouvert de cercles et de triangles de couleur différentes qui permettent de situer les stations hydrométriques et de donner une idée de l’intensité de la tendance estimée. Un <b>cercle</b> indique que la tendance n’est <b>pas significative</b> alors qu’un triangle indique que la tendance est significative. Un <b>triangle pointant vers le haut</b> indique que la tendance est à la <b>hausse</b> alors qu’un <b>triangle dont la pointe est vers le bas</b> indique une tendance à la <b>baisse</b>."
                   ))
                   )
    ),

#### 6.4.3. Page 3 ___________________________________________________
    page_circle(n=3, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help3_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>FOND DE CARTE</b>"
                   )),
                   
                   h4(HTML(
                       "<b>INTERACTION</b>"
                   )),
                   
                   p(HTML(
                       "Le fond de carte est interactif, cela veut dire qu’il est possible de se <b>déplacer</b> sur le planisphère en effectuant un <b>click gauche glisser</b>. De la même manière, il est aussi possible de <b>zoomer</b> en effectuant un <b>roulement de la molette de souris</b>."
                   )),

                   p(HTML(
                       "Les <b>cercles et triangles</b> sont aussi cliquables. Par défaut, le <b>clic</b> sur une station permet d’afficher le <b>graphique détaillé de l’analyse de tendance</b> de la variable étudiée."
                   ))
                   )  
    ),
    
#### 6.4.4. Page 4 ___________________________________________________
    page_circle(n=4, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help4_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ZOOM</b>"
                   )),
                   
                   p(HTML(
                       "Les interactions avec le fond de carte font apparaître le <b>bouton de zoom en haut à gauche</b> qui permet de re‐faire le <b>focus</b> sur l’ensemble des stations sélectionnées. Ainsi, si la sélection de station est réduite, ce même bouton peut apparaître afin de laisser la possibilité à l’utilisateur de laisser l’application choisir le zoom et le <b>positionnement de carte le plus adapté</b>. Lorsque le positionnement est optimale sur une sélection, un bouton de zoom différent apparaît à la même place. Ce nouveau bouton permet alors de <b>re‐faire le focus</b> non pas sur la sélection de station mais <b>sur la France</b> entière."
                   )),

                   p(HTML(
                       "Le mieux c'est d'essayer !"
                   ))
                   )
    ),

#### 6.4.5. Page 5 ___________________________________________________
    page_circle(n=5, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help5_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ANALYSE</b>"
                   )),

                   h4(HTML(
                       "<b>SÉLECTION</b>"
                   )),
                   
                   p(HTML(
                       "Les deux premiers boutons de la section de sélection permettent respectivement de sélectionner <b>toutes</b> les stations ou <b>aucunes</b>."
                   )),

                   p(HTML(
                       "Le troisième bouton de la ligne est le bouton de <b>sélection par clic</b> sur la carte. Une fois ce mode activé, un clic sur le symbole d’une station permet de <b>changer son état de sélection</b>. Lors du lancement de ce mode, une <b>barre d'outil</b> apparaît en haut à gauche et permet de terminer la sélection par clic."
                   )),
                   
                   p(HTML(
                       "Le quatrième bouton correspond au bouton de <b>sélection par polygone</b> sur la carte. Un polygone peut donc être tracé en plaçant des points sur la carte. Comme dans le mode précédent, une <b>barre d'outil</b> apparaît en haut à gauche de l’interface et permet de rendre la sélection par polygone additive ou soustractive."
                   )),
                   )
    ),


    # Une fois la sélection réalisée, les stations non‐sélectionnées sont représentées par un cercle neutre / . Les stations présentes dans la sélection sont localisées par un cercle ou un triangle / de couleur.


    
#### 6.4.6. Page 6 ___________________________________________________
    page_circle(n=6, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help6_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ANALYSE</b>"
                   )),

                   h4(HTML(
                       "<b>SÉLECTION</b>"
                   )),
                   
                   p(HTML(
                       "Le bouton <b>avertissement</b> est présent sur la seconde ligne. Lorsqu'il est sélectionné, comme par défaut, les stations qui présentent des <b>chroniques de moins de 30 ans</b> sont situées des symboles au <b>contour jaune</b> et lorsque les chroniques sont complètement <b>manquantes</b>, les symboles utilisés sont des cercles au <b>contour rouge</b>. Dans le cas où le bouton est déselectionné, les stations qui présentent des avertissements sont <b>retirées automatiquement</b> de la sélection."
                   )),

                   p(HTML(
                       "Enfin, la sélection peut se faire à l'aide d'une <b>barre de recherche textuelle</b> avec complétion automatique. Des stations peuvent être sélectionnées à l’aide de <b>mots clés</b> contenus dans leur nom, le nom de leur cours d’eau, le lieu où elles sont situées de même que leur région‐hydrographique et bassin‐hydrographique. Ce mode de sélection est <b>additif</b> et il est possible d’ajouter ou de supprimer plusieurs recherches textuelles."
                   )),
                   )
    ),

    
#### 6.4.7. Page 7 ___________________________________________________
    page_circle(n=7, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help7_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ANALYSE</b>"
                   )),
                   
                   h4(HTML(
                       "<b>RÉGIME ET VARIABLE</b>"
                   )),
                   
                   p(HTML(
                       "La sélection de la <b>variable hydrologique utilisée pour l'analyse de tendance</b> s'effectue à l'aide des sections Régime et Variable."
                   )),

                   p(HTML(
                       "La séction <b>Régime</b> permet de sélectionner la composantes du <b>régime des cours d'eau</b> que l'on souhaite étudié : <b>Crue</b>, <b>Crue Nivale</b>, <b>Moyennes Eaux</b> ou <b>Étiage</b>. Chaque bouton permet d'afficher un panel de variables caractéristiques de l'étude du régime choisi."
                   )),

                   p(HTML(
                       "La séction <b>Variable</b> permet dans un second temps de sélectionner la <b>variable que l'on souhaite étudier</b>."
                   )),
                   )
    ),

#### 6.4.8. Page 8 ___________________________________________________
    page_circle(n=8, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help8_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ANALYSE</b>"
                   )),
                   
                   h4(HTML(
                       "<b>ANNÉE HYDROLOGIQUE ET PÉRIODE</b>"
                   )),
                   
                   p(HTML(
                       "L’analyse de tendance présente deux <b>paramètres temporels</b> qui sont sélectionnés grâce aux section <b>Année Hydrologique</b> et <b>Période</b>."
                   )),

                   p(HTML(
                       "Le premier paramètre est le <b>mois de début de l’Année Hydrologique</b> qui par défaut est fixé sur le mois de janvier. Ce choix se fait à l’aide d’un <b>curseur horizontal simple</b>."
                   )),

                   p(HTML(
                       "Le second aspect temporel est le choix de <b>la période d’analyse de tendance</b>. Cette sélection se fait avec <b>un double curseur horizontal</b> qui permet de choisir une date de début et de fin de la période d’analyse. L’année de fin est incluse et <b>par défaut</b> la période temporelle s’étend de l’année <b>1968</b> à <b>2020</b>."
                   )),
                   ) 
    ),

#### 6.4.9. Page 9 ___________________________________________________
    page_circle(n=9, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help9_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>ANALYSE</b>"
                   )),
                   
                   h4(HTML(
                       "<b>SIGNIFICATIVITÉ</b>"
                   )),
                   
                   p(HTML(
                       "La dernière section correspond au seuil de <b>significativité du test statistique de Mann‐Kendall</b>, c’est‐à‐dire <b>la probabilité avec laquelle on accepte de se tromper</b> sur l’affirmation de l’existence d’une tendance. Le choix de ce seuil est fait à l’aide de boutons qui permettent de sélectionner la valeur de <b>1%</b>, <b>5%</b> ou <b>10%</b>. Par défaut, la valeur de <b>10%</b> est sélectionnée ce qui s’avère être la valeur la moins contraignante."
                   ))
                   )
    ),

#### 6.4.10. Page 10 _________________________________________________
    page_circle(n=10, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),

    hidden(
        fixedPanel(id="help10_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>PERSONNALISATION</b>"
                   )),

                   h4(HTML(
                       "<b>FOND DE CARTE</b>"
                   )),
                   
                   p(HTML(
                       "Trois <b>thèmes de couleur</b> sont disponible pour personnalisé le <b>fond de carte</b> : un thème <b>Clair</b>, un thème en couleur appelé <b>Terrain</b> qui représente les reliefs et un thème <b>Sombre</b>. Le thème par <b>défaut</b> est le thème <b>Clair</b>."
                   )),

                   h4(HTML(
                       "<b>ÉCHELLE DE COULEUR</b>"
                   )),
                   
                   p(HTML(
                       "Il est aussi possible d’afficher ou non sur l’interface l'<b>échelle de couleur des tendances</b>. Cette échelle est <b>évolutive</b> en fonction de la <b>sélection de stations</b> et associe une couleur <b>marron</b> à une <b>tendance négative</b> et <b>turquoise</b> à une tendance <b>positive</b>. Plus précisément, ... ."
                   )),
                   )
    ),

#### 6.4.11. Page 11 _________________________________________________
    page_circle(n=11, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help11_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>PRODUCTION DE CARTE</b>"
                   )),
                   
                   p(HTML(
                       "Il est possible de <b>télécharger l’état de la carte</b> en cliquant sur le format souhaité. La carte obtenu en <b>png</b> inclue l’<b>échelle de couleur</b> lorsqu’elle est affichée mais masque le reste de l’interface."
                   ))
                   )
    ),

#### 6.4.12. Page 12 _________________________________________________
    page_circle(n=12, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help12_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>TÉLÉCHARGEMENT DE FICHES STATIONS</b>"
                   )),
                   
                   p(HTML(
                       "Il est possible de <b>télécharger des fiches stations</b> récapitulative de l'analyse de tendance. Le premier bouton est le bouton de <b>téléchargement par clic</b> sur la carte. Une fois ce mode activé, un clic sur le symbole d’une station permet de <b>télécharger la fiche station</b> associée. Lors du lancement de ce mode, une <b>barre d'outil</b> apparaît en haut à gauche et permet de terminer la sélection par clic."
                   )),

                   p(HTML(
                       "Il est aussi possible de <b>télécharger</b> l'ensemble des fiches stations de <b>la sélection de stations</b> précédemment réalisé dans l'analyse en cliquant sur le bouton <b>Sélection</b> mais aussi de <b>télécharger l'entièreté des fiches stations</b> disponible en cliquant sur le bouton <b>Toute</b>."
                   )),
                   )
    ),

#### 6.4.13. Page 13 _________________________________________________
    page_circle(n=13, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help13_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>M</b>"
                   )),
                   
                   p(HTML(
                       "M"
                   ))
                   )
    ),

#### 6.4.14. Page 14 _________________________________________________
    page_circle(n=14, leftBase=leftHelp, widthHelp=widthHelp,
                top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                dh=dhNavHelp),
    
    hidden(
        fixedPanel(id="help14_panel",
                   class="Panel card-text",
                   left=leftHelp, top=topHelp,
                   width=widthHelp, height="auto",
                   
                   h1(HTML(
                       "<b>INFORMATION</b>"
                   )),
                   
                   p(HTML(
                       "Le logo <b>INRAE</b> en bas à droite de l'interface est un bouton cliquable qui permet d'<b>afficher des informations</b>. Il est mentionné les <b>noms du développeur</b> et du <b>référent INRAE</b> sous forme de liens vers leur <b>adresse email</b>. La troisième ligne renseigne sur l'<b>hébergeur SK8</b> et la dernière ligne donne un lien vers le site qui à donné l'<b>inspiration de l'interface</b>."
                   ))
                   )
        ),

#### 6.4.x. Nave button ______________________________________________
    hidden(
        fixedPanel(id="before_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " - ", dhNavHelp, "px)"),
                   top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='before_button',
                          label=NULL,
                          icon_name=iconLib$navigate_before_white)
                   )
    ),


    hidden(
        fixedPanel(id="next_panelButton",
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dhNavHelp*N_helpPage, "px)"),
                   top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='next_button',
                          label=NULL,
                          icon_name=iconLib$navigate_next_white)
                   )
    ),

    hidden(
        fixedPanel(id='closeHelp_panelButton',
                   left=paste0("calc(", leftHelp,
                               " - ", 0.5*widthHelp, "px",
                               " + ", dhNavHelp*(N_helpPage+1), "px)"),
                   top=paste0("calc(", topHelp, " + ", dyNavHelp, "px)"),
                   width="auto", height="auto",
                   Button(class="Button-icon",
                          inputId='closeHelp_button',
                          label=NULL,
                          icon_name=iconLib$close_white,
                          tooltip=word("tt.help.close")) 
                   )
    ),
    

    )
