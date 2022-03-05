library(shiny)
library(leaflet)
library(shinyjs)


# ui = bootstrapPage(
#     # tabsetPanel(
        
#     #     tabPanel(title=word('t1'), {
#     #         tags$style(type = "text/css",
#     #                    "html, body {width:100%;height:100%}")
#     #         leafletOutput("map", width="100%", height="100%")
#     #     }),
        
#     #     tabPanel(word('t2')),
#     #     tabPanel(word('t3'))
        
#     # )
    
#     tags$style(type = "text/css",
#                "html, body {width:100%;height:100%}"),
#     leafletOutput("map", width="100%", height="100%"),

#     absolutePanel(
#         id="controls", class="panel panel-default", fixed=TRUE,
#         draggable=FALSE, top="auto", left=10, right="auto", bottom=10,
#         width="auto", height="auto",
        

        
#         tags$div(id='demo', class="collapse",
#                  "aaaaaaaaaaaaaaaa"),
        
#         HTML('<button 
# style="background-color: transparent;border:none;color:#00B0F0;width:100px"
# data-toggle="collapse"
#  data-target="#demo">
# Menu
# </button>')

#     )

# ) 


ui = bootstrapPage(
    # tabsetPanel(
        
    #     tabPanel(title=word('t1'), {
    #         tags$style(type = "text/css",
    #                    "html, body {width:100%;height:100%}")
    #         leafletOutput("map", width="100%", height="100%")
    #     }),
        
    #     tabPanel(word('t2')),
    #     tabPanel(word('t3'))
        
    # )

    useShinyjs(),
    
    tags$style(type = "text/css",
               "html, body {width:100%;height:100%}"),
    leafletOutput("map", width="100%", height="100%"),


    hidden(
        absolutePanel(
            id='Menu',
            style="background-color: rgba(40, 40, 40, 0.8)",
            left=10, bottom=60,
            checkboxInput('input_draw_point', 'Draw point', FALSE ),
            verbatimTextOutput('summary'))),

    fixedPanel(left=10, bottom=10,
               width="auto", height="auto",
               actionButton('menuButton', HTML(paste0("<b>","Menu","</b>")),
                            style="color: #fff; background-color: rgba(35, 35, 35, 0.8); border-color: transparent"))

)
