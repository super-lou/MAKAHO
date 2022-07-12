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
# R/settings.R


# Path to the data
computer_data_path = 'data'       

# Resources directory
resources_path = 'resources'

# INRAE logo path
INRAElogo_path = file.path(resources_path,
                           "logo", "Logo-INRAE_Transparent.png")

# Icon directory
icon_dir = 'icons'
# Creates icon library 
iconLib = create_iconLib(icon_dir, resources_path)

# Filename of the map tiles theme available
theme_file = 'theme.txt'
# Selection of the provider of map
provider =
    'jawg'
    # 'stadia'

# Token for the map 
jawg_token =
    "hEjAgwvvpEJBpIR62stbJUflOVZXM73MoB1hQGAR69fCtoNVQiHJOKp8lVlPOdFH"

# today's date
today = Sys.Date()

# Language
language = 'FR'

# Localisation
lonFR = 2.213749
latFR = 46.727638
zoomFR = 6
boundsFR = list(north=51.4677, east=17.68799,
                south=41.52503, west=-13.24951)

# Min and max zoom of the map
minZoom = 1
maxZoom = 20

# Name of the dictionnary to use for the translation
dico_file = 'dico.txt'
# Creates the dictionnary
dico = create_dico(dico_file, resources_path)


varProba = list(fA=c("90%", "95%", "99%"),
                Qp=c("10%", "25%", "50%", "75%", "90%"))

Var = get_Var(dico, varProba)


# Creates a vector of months name
Months = c(word("ana.m01"), word("ana.m02"), word("ana.m03"),
           word("ana.m04"), word("ana.m05"), word("ana.m06"),
           word("ana.m07"), word("ana.m08"), word("ana.m09"),
           word("ana.m10"), word("ana.m11"), word("ana.m12"))

# Creates a vector of years
Years = 1900:as.numeric(format(today, "%Y"))

# Level of risk
sigProba = c("1%", "5%", "10%")
sigVal = as.numeric(gsub('%', '' , sigProba))/100

nbTick = 10

colorStep = 10
Palette = Palette_ground()
reverse = FALSE

exQprob = 0.01

analyseMinYear = 30

# Personnal colors
grey99COL = "#fcfcfc"
grey98COL = "#fafafa"
grey97COL = "#f7f7f7"
grey94COL = "#f0f0f0"
grey90COL = "#e5e5e5"
grey85COL = "#d9d9d9"
grey75COL = "#bfbfbf"
grey70COL = "#b3b3b3"
grey50COL = "#808080"
grey40COL = "#666666"
grey30COL = "#4d4d4d"
grey20COL = "#333333"
grey18COL = "#2e2e2e"
grey15COL = "#262626"
grey9COL = "#171717"

yellowCOL = "#fddc5c"
orangeCOL = "#ffa62b"
redCOL = "#dc343b"

lightCyanCOL = "#66c1bf"
midCyanCOL = "#008c8e"
darkCyanCOL = "#275662"
INRAECyanCOL = "#00a3a6"

validColor = grey50COL
invalidColor = yellowCOL
missColor = redCOL

none1Color_light = grey85COL
none2Color_light = grey94COL

none1Color_dark = grey9COL
none2Color_dark = grey18COL


N_helpPage = 15
widthHelp = 350
leftHelp = "51%"
topHelp = "50%"
dyNavHelp = 270
dhNavHelp = 21


## ash
hydrograph_period = c("1968-01-01", "1988-12-31")

data_path = file.path(computer_data_path, 'fst', 'data.fst')
meta_path = file.path(computer_data_path, 'fst', 'meta.fst')
if (!file.exists(data_path) | !file.exists(meta_path)) {
    df_data = extract_data(computer_data_path, filedir, "all")
    df_meta = extract_meta(computer_data_path, filedir, "all")
    df_meta = get_lacune(df_data, df_meta)
    df_meta = get_hydrograph(df_data, df_meta,
                             period=hydrograph_period)$meta
    write_dataFST(df_data, filename='data.fst', filedir='fst',
                  resdir=computer_data_path)
    write_dataFST(df_meta, filename='meta.fst', filedir='fst',
                  resdir=computer_data_path)
}

to_do = c('station_trend_analyse')
filedir = "RRSE"
trend_period = list(c(1, 2))

init_var_file = 'default.R'
var_dir = 'variable'
var_to_analyse_dir = ''
to_assign_out = c()
hydroPeriod_mode = 'fixed'
saving = c()
fast_format = TRUE
read_results = FALSE
df_flag = NULL
