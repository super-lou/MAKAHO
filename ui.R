

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
                tags$br(),

                pickerInput(
                    inputId="code_picker",
                    label="Code", 
                    choices=FALSE,
                    multiple=TRUE,
                    selected=NULL,
                    options=list(`live-search`=TRUE, `actions-box`=TRUE)),
                     
                selectInput("varName", word('varT'),
                            varNameList),

                hidden(
                    radioButtons(inputId="proba_choice",
                                 label=word("varp"),
                                 inline=TRUE,
                                 choices=FALSE)),
                
                sliderInput("dateMonth_slider", word("dm"),
                            step=1,
                            sep='',
                            min=1,
                            max=12,
                            value=1),

                sliderInput("dateYear_slider", word("dy"),
                            step=1,
                            sep='',
                            min=1900,
                            max=as.numeric(format(today, "%Y")),
                            value=c(1968, 2020)),
                 
                textOutput("period"),
                tags$br(),

                radioButtons(inputId="signif_choice",
                             label=word("sig"),
                             inline=TRUE,
                             selected=sigP[3],
                             choices=sigP),

                radioButtons(inputId="trendArea_choice",
                             label=word("ctT"),
                             inline=TRUE,
                             selected=word("cts"),
                             choices=c(word("cts"), word("ctr"))),

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
               )


    
)
