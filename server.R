library(shiny)
library(leaflet)

minZoom = 1
maxZoom = 13


server = function (input, output, session) {

    output$map = renderLeaflet({
        map = leaflet(options=leafletOptions(minZoom=minZoom,
                                             maxZoom=maxZoom,
                                             worldCopyJump=FALSE,
                                             zoomControl=FALSE))
        map = setView(map,
                      centroids$longitude[centroids$country == country],
                      centroids$latitude[centroids$country == country],
                      6)
        
        map = addTiles(map,
                       urlTemplate=urlTile)
    })

    observeEvent(input$Menu_button, {
        toggle('Menu')
    })


    values = reactiveValues(varName = " ")
    
    observeEvent(input$Crue_button, {
        values$varName = c("Débit Max An",
                          "Date Max An",
                          "Fréquence annuelle [Q> Qp]")
    })
    
    observeEvent(input$CrueNivale_button, {
        values$varName = c("Débit Max An",
                          "Date Max An",
                          "Date début Fonte (10% volume)",
                          "Date méd. Fonte (50% volume)",
                          "Date fin Fonte (90% volume)",
                          "Volume Fonte",
                          "Durée Fonte")
    })

    observeEvent(input$MoyennesEaux_button, {
        values$varName = c("Débit moyen annuel QA",
                          "Débit moyen mensuel",
                          "Décile Qp (débits classés)")
    })

    observeEvent(input$MoyennesEaux_button, {
        values$varName = c("Débit Min An",
                          "Débit Mensuel Étiage QMNA",
                          "Débit moyen Mini VCN10",
                          "Date début Étiage (10% déficit)",
                          "Date méd. Étiage (50% déficit)",
                          "Date fin Étiage (90% déficit)",
                          "Volume déficite",
                          "Durée Étiage")
    })

    

    output$varName <- renderText({
        paste(values$varName, collapse="")
    })
    

} 
