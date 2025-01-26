# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1,
#                     Éric Sauquet (eric.sauquet@inrae.fr)*1,
#                     Michel Lang (michel.lang@inrae.fr)*1,
#                     Jean-Philippe Vidal (jean-philippe.vidal@inrae.fr)*1,
#                     Benjamin Renard (benjamin.renard@inrae.fr)*1
#                     
# *1   INRAE, France
#
# This file is part of MAKAHO R shiny app.
#
# MAKAHO R shiny app is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# MAKAHO R shiny app is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with MAKAHO R shiny app.
# If not, see <https://www.gnu.org/licenses/>.


## 1. GENERAL ________________________________________________________
library(stringr)
library(dplyr)

to_create = "RRSE"
MAKAHO_data_path = "data"
computer_RSSE_path =
    "/home/lheraut/Documents/INRAE/data/HYDRO/2024-09-XX/RRSE"
data_RRSE_path = file.path(MAKAHO_data_path, "fst", "data_RRSE.fst")
meta_RRSE_path = file.path(MAKAHO_data_path, "fst", "meta_RRSE.fst")

## 2. RRSE ___________________________________________________________
if ("RRSE" %in% to_create) {
    Paths = list.files(computer_RSSE_path,
                       pattern=".txt",
                       full.names=TRUE)

    RRSE = ASHE::create_HYDRO3(Paths, variable_to_load="Qm3s",
                               verbose=TRUE)
    data_RRSE = RRSE$data
    meta_RRSE = RRSE$meta
    
    ASHE::write_tibble(data_RRSE,
                       path=data_RRSE_path)
    ASHE::write_tibble(meta_RRSE,
                       path=meta_RRSE_path)
}


## 3. Explore2 _______________________________________________________
if ("Explore2" %in% to_create) {
    NC_path = "/home/louis/Documents/bouleau/INRAE/data/Explore2/hydrologie/diagnostic/SMASH_20230303.nc"
    tools_path = "/home/louis/Documents/bouleau/INRAE/project/Explore2_project/Explore2_toolbox/tools.R"
    codes_hydro_selection_path = file.path(computer_data_path, "Explore2", "hydrologie", "Selection_points_simulation.csv")
    codes_hydro_check_security_path = file.path(computer_data_path, "Explore2", "hydrologie", "Selection_stations_EDF_def.csv")

    hydro_dirpath = "Explore2/hydrologie/Explore2 HYDRO QJM critiques 2023"

    data_Explore2_path = file.path(MAKAHO_data_path, 'fst',
                                   'data_Explore2.fst')
    meta_Explore2_path = file.path(MAKAHO_data_path, 'fst',
                                   'meta_Explore2.fst')
    if (!file.exists(data_Explore2_path) |
        !file.exists(meta_Explore2_path)) {

        codes_selection_data = ASHE::read_tibble(codes_hydro_selection_path)
        codes_selection_data = dplyr::filter(codes_selection_data,
                                             is.na(PointsSupprimes))

        secure_codes =
            as.character(read.csv2(codes_hydro_check_security_path)$CODE)

        ### /!\ ###
        codes_selection_data =
            codes_selection_data[!(codes_selection_data$CODE %in%
                                   secure_codes),]
        ###########    
        
        codes_selection_data =
            codes_selection_data[codes_selection_data$Référence %in% 1,]
        codes8_selection = codes_selection_data$CODE
        codes10_selection = codes_selection_data$SuggestionCode
        codes8_selection = codes8_selection[!is.na(codes8_selection)]
        codes10_selection = codes10_selection[!is.na(codes10_selection)]

        CodeSUB8 = codes8_selection
        CodeSUB10 = codes10_selection
        
        source(tools_path)
        data_sim = NetCDF_to_tibble(NC_path,
                                    chain="SMASH",
                                    type="hydrologie",
                                    mode="diagnostic")

        data_sim$Code = convert_codeNtoM(data_sim$Code, N=10, M=8)

        Code = levels(factor(data_sim$Code))
        Code_filename = paste0(Code, "_HYDRO_QJM.txt")

        meta_Explore2 = create_meta_HYDRO(
            computer_data_path,
            hydro_dirpath,
            Code_filename,
            verbose=FALSE)

        data_obs = create_data_HYDRO(
            computer_data_path,
            hydro_dirpath,
            Code_filename,
            val2keep=c(val_E2=0),
            verbose=FALSE)

        
        data_obs = dplyr::arrange(data_obs, Code)
        meta_Explore2 = get_lacune(data_obs, meta_Explore2)
        

        data_Explore2 = dplyr::inner_join(data_obs,
                                          dplyr::select(data_sim,
                                                        c("Code", "Date",
                                                          "P", "Pl", "Ps", "T")),
                                          by=c("Code", "Date"))

        # hydrograph
        write_tibble(data_Explore2,
                     filedir=file.path(MAKAHO_data_path, 'fst'),
                     filename='data_Explore2.fst')
        write_tibble(meta_Explore2,
                     filedir=file.path(MAKAHO_data_path, 'fst'),
                     filename='meta_Explore2.fst')
    }
}
