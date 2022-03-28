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
### 1.1. Panel _______________________________________________________
    tags$style(type = "text/css",
               "html, body {width:100%;height:100%}"),
    leafletOutput("map", width="100%", height="100%"),

    hidden(
        absolutePanel(
            id='theme_panel',
            style="background-color: rgba(100, 100, 100, 0.8)",
            fixed=TRUE,        
            width="auto", height="auto",
            left=60, top=10,
            
            tags$div(
### 1.2. Background selection ________________________________________
                     radioButtons(inputId="theme_choice",
                                  label=NULL,
                                  inline=TRUE,
                                  selected=word("t.theme.light"),
                                  choices=c(word("t.theme.light"),
                                            word("t.theme.ter"),
                                            word("t.theme.dark")))
                 )
        )
    ),
### 1.3. Button ______________________________________________________
    fixedPanel(left=10, top=10,
               width="auto", height="auto",
               actionButtonI('theme_button', label=NULL,
                             style=panelButtonCSS,
                             icon_name=iconLib$palette
                             )
               ),

    
## 2. ANALYSE ________________________________________________________
### 2.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            style="background-color: rgba(100, 100, 100, 0.8)",
            fixed=TRUE,        
            width=300, height=500,
            left=10, bottom=60,
            
            tags$div(
### 2.2. Code selection ______________________________________________
                pickerInput(
                    inputId="code_picker",
                    label=word("a.sta"), 
                    choices=NULL,
                    multiple=TRUE,
                    selected=NULL,
                    options=list(size=7,
                                 `live-search`=TRUE,
                                 `actions-box`=TRUE)),

### 2.3. Variable selection __________________________________________
                selectInput("varName", word('a.varT'),
                            varNameList),

                hidden(
                    radioButtons(inputId="proba_choice",
                                 label=word("a.varp"),
                                 inline=TRUE,
                                 choices=FALSE)),

### 2.4. Period selection ____________________________________________
                chooseSliderSkin("Flat", "#00A5A8"),
                tags$style(type="text/css",
                           ".irs-grid-pol.small {height: 0px;}"),

                sliderTextInput(inputId="dateMonth_slider",
                                label=word("a.dm"),
                                grid=TRUE,
                                force_edges=TRUE,
                                choices=Months),

                sliderInput("dateYear_slider", word("a.dy"),
                            step=1,
                            sep='',
                            min=1900,
                            max=as.numeric(format(today, "%Y")),
                            value=c(1968, 2020)),
                 
                textOutput("period"),
                tags$br(),

### 2.5. Statistical option ______________________________________________
                radioGroupButtons(inputId="signif_choice",
                                  label=word("a.sig"),
                                  size="sm",
                                  # status=radioButtonCSS,
                                  choices=sigP,
                                  selected=sigP[3]),
                
                radioGroupButtons(inputId="trendArea_choice",
                                  label=word("a.ctT"),
                                  size="sm",
                                  # status=radioButtonCSS,
                                  choices=c(word("a.cts"), word("a.ctr")),
                                  selected=word("a.cts"))
                )
        )
    ),
    
### 2.6. Button ______________________________________________________
    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('ana_button',
                            HTML(paste0("<b>","Analyse","</b>")),
                            style=panelButtonCSS,
                            icon_name=iconLib$analytics
                            )          
               ),

    
## 3. SEARCH _________________________________________________________
### 3.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='search_panel',
            style="background-color: transparent",
            fixed=TRUE,
            width="auto", height="33",
            left=180, bottom=10,

### 3.2. Search bar __________________________________________________
            tags$head(tags$style(HTML('#search_input+ div>.selectize-dropdown{bottom: 100% !important; top:auto!important;}'))),

            selectizeInput(
                inputId="search_input", 
                label=NULL,
                multiple=TRUE,
                choices=NULL,
                options=list(
                    create=FALSE,
                    placeholder=word("s.back"),
                    onDropdownOpen=
                        I("function($dropdown) {if (!this.lastQuery.length) {this.close(); this.settings.openOnFocus = false;}}"),
                    onType=
                        I("function (str) {if (str === \"\") {this.close();}}"),
                    onItemAdd=
                        I("function() {this.close();}")
                ))
        )
    ),

### 3.3. Button ______________________________________________________
    fixedPanel(left=130, bottom=10,
               width="auto", height="auto",
               actionButtonI('search_button', label=NULL,
                             style=panelButtonCSS,
                             icon_name=iconLib$search
                             )
               ),

    
## 4. INFO ___________________________________________________________
### 4.1. Panel _______________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            style="background-color: rgba(100, 100, 100, 0.8)",
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=60,

### 4.2. Contact info ________________________________________________
            tags$div(tags$b(word("i.con")),
                     tags$br(),
                     word("i.dev"),
                     tags$a(href="mailto:louis.heraut@inrae.fr",
                            "Louis Héraut"),
                     tags$br(),
                     word("i.ref"),
                     tags$a(href="mailto:michel.lang@inrae.fr",
                            "Michel Lang")
                 )
        )
    ),
    
### 4.3. Button ______________________________________________________    
    fixedPanel(right=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('info_button', label=NULL,
                             style=infoButtonCSS,
                             icon_name=iconLib$INRAElogo
                             )
               )
    
)
