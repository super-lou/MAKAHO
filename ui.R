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
            width="auto", height="auto",
            left=10, bottom=60,
            
            tags$div(
                     selectInput("var", word('varTitle'),
                                get_listVar()),
                     tags$br(),
                     textOutput("var")


                 )
        )
    ),

    

    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButton('Menu_button', HTML(paste0("<b>","Menu","</b>")),
                            style="color: #fff; background-color: rgba(35, 35, 35, 0.8); border-color: transparent"))

)
