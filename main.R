# Work path (it normally needs to end with '\\sht' directory)
computer_work_path = 
    "/home/louis/Documents/bouleau/INRAE/CDD_shiny/sht"

# Sets working directory
setwd(computer_work_path)

library(dplyr)

source(file.path('Rcode', 'tools.R'))
source(file.path('Rcode', 'style.R'))

# Path to the data
computer_data_path = file.path(computer_work_path, 'data')

# Resources directory
resources_path = file.path(computer_work_path, 'resources')

theme_file = 'theme.txt'
provider = 'jawg'

today = Sys.Date()

language = 'FR'
country = 'France'

minZoom = 1
maxZoom = 13

dico_file = 'dico.txt'
dico = create_dico(dico_file, resources_path)


centroids_path = file.path(resources_path, 'centroids.txt')
centroids = tibble(read.table(centroids_path, header=TRUE,
                              quote='', sep=";"))
for (j in 1:ncol(centroids)) {
    if (is.factor(centroids[[j]])) {
        centroids[j] = as.character(centroids[[j]])
    }
}

area_path = file.path(resources_path, 'area.txt')
area = tibble(read.table(area_path, header=TRUE,
                              quote='', sep=";"))

area$country = as.character(area$country)
area$area = as.double(area$area)




varP = c(word("var1.3"), word("var3.3"))


source('ui.R', encoding='UTF-8')
source('server.R', encoding='UTF-8')
shinyApp(ui=ui, server=server)
