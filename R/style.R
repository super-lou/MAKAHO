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
# R/style.R





panelButtonCSS =
    "color: #fff; background-color: rgba(35, 35, 35, 0.8); border-color: transparent"

polyButtonCSS =
    "margin-top: 25px; margin-bottom: 0px; color: rgba(35, 35, 35); background-color: #fff; border-color: transparent"

infoButtonCSS =
    "padding-left: 0px; padding-right: 0px; padding-top: 0px; padding-bottom: 0px; color: #fff; background-color: rgba(0, 0, 0, 0); border-color: transparent; font-size: 25px"


inraeRadioCSS=
"
.btn-inrae {
    background-color: #00A5A8;
}
"



# tags$head(tags$style(HTML('#search_input+ div>.selectize-dropdown{bottom: 100% !important; top:auto!important;}'))) # put above selectizeInput

# searchHTML = HTML("
# .selectize-input.items.not-full.has-options:before {
#  content: '\\e003';
#  font-family: \"Glyphicons Halflings\";
#  line-height: 2;
#  display: block;
#  position: absolute;
#  top: 0;
#  left: 0;
#  padding: 0 4px;
#  font-weight:900;
#  }
  
#   .selectize-input.items.not-full.has-options {
#     padding-left: 24px;
#   }
 
#  .selectize-input.items.not-full.has-options.has-items {
#     padding-left: 0px;
#  }
 
#   .selectize-input.items.not-full.has-options .item:first-child {
#       margin-left: 20px;
#  }
# ")
