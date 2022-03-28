
# Work path (it normally needs to end with '\\sht' directory)
computer_work_path = 
    "/home/louis/Documents/bouleau/INRAE/CDD_shiny/sht"

# Sets working directory
setwd(computer_work_path)

# Sourcing R files
source(file.path('R', 'tools.R'), encoding='UTF-8')
source(file.path('R', 'color_manager.R'), encoding='UTF-8')
source(file.path('R', 'marker_manager.R'), encoding='UTF-8')
source(file.path('R', 'style.R'), encoding='UTF-8')
source('settings.R', encoding='UTF-8')

# Sourcing app
source('ui.R', encoding='UTF-8')
source('server.R', encoding='UTF-8')

# Running app
shinyApp(ui=ui, server=server)
