library(shiny)
library(leaflet)
library(shinyjs)


ui = bootstrapPage(

    useShinyjs(),
    
    tags$style(type = "text/css",
               "html, body {width:100%;height:100%}"),
    leafletOutput("map", width="100%", height="100%"),


    hidden(
        absolutePanel(
            id='Menu',
            style="background-color: rgba(40, 40, 40, 0.8)",
            fixed=TRUE,        
            width=275, height=550,
            left=10, bottom=60,
            
            tags$div(
                tags$br(),
                selectInput("var", word('varT'),
                            get_listVar()),
                
                # sliderInput("anHydro_sli",,
                #             min=1, max=12, value=12),
                
                # dateRangeInput("dateAnalyse_inp",
                #                word("da"),
                #                startview="decade",
                #                separator= "/"),

                numericInput("anHydro_inp",
                             word("dh"),
                             1,
                             min=1,
                             max=12),

                fluidRow(
                    column(6,
                           numericInput("dateStart_inp",
                                        word("ds"),
                                        1968,
                                        min=1900,
                                        max=format(today, "%Y"))),
                    column(6,
                           numericInput("dateEnd_inp",
                                        word("de"),
                                        2020,
                                        min=1900,
                                        max=format(today, "%Y")))
                ),
                    
                textOutput("period"),
                tags$br(),

                radioButtons(inputId="signif_cho",
                             label=word("sig"),
                             inline=TRUE,
                             selected="10%",
                             choices=c("1%", "5%", "10%")),

                radioButtons(inputId="carte_cho",
                             label=word("ctT"),
                             inline=TRUE,
                             selected=word("cts"),
                             choices=c(word("cts"), word("ctr"))),
                

                )
        )
    ),

    

    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButton('Menu_but', HTML(paste0("<b>","Menu","</b>")),
                            style="color: #fff; background-color: rgba(35, 35, 35, 0.8); border-color: transparent"))

)
