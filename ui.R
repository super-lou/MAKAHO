

ui = bootstrapPage(

    useShinyjs(),

    ### ______________________________________________________________
    tags$style(type = "text/css",
               "html, body {width:100%;height:100%}"),
    leafletOutput("map", width="100%", height="100%"),

    ### ______________________________________________________________
    hidden(
        absolutePanel(
            id='ana_panel',
            style="background-color: rgba(40, 40, 40, 0.8)",
            fixed=TRUE,        
            width=300, height=500,
            left=10, bottom=60,
            
            tags$div(

                pickerInput(
                    inputId="code_picker",
                    label=word("a.sta"), 
                    choices=NULL,
                    multiple=TRUE,
                    selected=NULL,
                    options=list(size=7,
                                 `live-search`=TRUE,
                                 `actions-box`=TRUE)),
                     
                selectInput("varName", word('a.varT'),
                            varNameList),

                hidden(
                    radioButtons(inputId="proba_choice",
                                 label=word("a.varp"),
                                 inline=TRUE,
                                 choices=FALSE)),

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

    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('ana_button',
                            HTML(paste0("<b>","Analyse","</b>")),
                            style=panelButtonCSS,
                            icon_name=iconLib$analytics
                            )          
               ),

    textOutput("trend"),


    ### ______________________________________________________________
    hidden(
        absolutePanel(
            id='map_panel',
            style="background-color: rgba(40, 40, 40, 0.8)",
            fixed=TRUE,        
            width="auto", height="auto",
            left=60, top=10,
            
            tags$div(
                radioButtons(inputId="theme_choice",
                             label=NULL,
                             inline=TRUE,
                             selected=word("r.theme.light"),
                             choices=c(word("r.theme.light"),
                                       word("r.theme.ter"),
                                       word("r.theme.dark")))
                )
        )
    ),
    
    fixedPanel(left=10, top=10,
               width="auto", height="auto",
               actionButtonI('map_button', label=NULL,
                             style=panelButtonCSS,
                             icon_name=iconLib$palette
                             )
               ),

    ### ______________________________________________________________
    hidden(
        absolutePanel(
            id='search_panel',
            style="background-color: transparent",
            fixed=TRUE,
            width="auto", height="33",
            left=180, bottom=10,

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
    
    fixedPanel(left=130, bottom=10,
               width="auto", height="auto",
               actionButtonI('search_button', label=NULL,
                             style=panelButtonCSS,
                             icon_name=iconLib$search
                             )
               ),

    ### ______________________________________________________________
    hidden(
        absolutePanel(
            id='info_panel',
            style="background-color: rgba(40, 40, 40, 0.8)",
            fixed=TRUE,
            width="auto", height="auto",
            right=10, bottom=60,
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
    
    fixedPanel(right=10, bottom=10,
               width="auto", height="auto",
               actionButtonI('info_button', label=NULL,
                             style=infoButtonCSS,
                             icon_name=iconLib$INRAElogo
                             )
               )
    
)
