#!/usr/bin/env Rscript   
# use chmod ug+x to make this file executable


# Copyright 2022-2023 Louis Héraut (louis.heraut@inrae.fr)*1
#
# *1   INRAE, France
#
# This file is part of CARD R library.
#
# CARD R library is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# CARD R library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CARD R library.
# If not, see <https://www.gnu.org/licenses/>.


suppressPackageStartupMessages(library(argparse))

parser = ArgumentParser()

parser$add_argument('-C', '--CARD', type="character",
                    default=".",
                    help="The CARD directory path (need to ends by 'CARD').")
parser$add_argument('-t', '--tmp', type="character",
                    default="",
                    help="The temporary directory path. If not provided, it will default to the value of 'CARD'.")
parser$add_argument('-l', '--layout', nargs='+', type="character",
                    default="EX [ QA ]",
                    help="A character vector specifying the layout of files to be managed. The default layout is c('EX', '[', 'QA', ']').")
parser$add_argument("-w", "--underscore_to_white", action="store_true", default=TRUE,
                    help="Logical. If TRUE, underscores in file names will be replaced with spaces. Default is TRUE.")
parser$add_argument("-i", "--add_id", action="store_true", default=TRUE,
                    help="Logical. If TRUE, numerical id will be added to the start of the file names. Default is TRUE.")
parser$add_argument("-o", "--overwrite", action="store_true", default=TRUE,
                    help="Logical. If TRUE, existing files in the temporary directory will be overwritten. Default is TRUE.")
parser$add_argument("-v", "--verbose", action="store_true", default=FALSE,
                    help="Logical. If TRUE, intermediate messages will be printed during the execution of the function. Default is FALSE.")

args = parser$parse_args()

dev_file = "/home/louis/Documents/bouleau/INRAE/project/EXstat_project/EXstat/R/CARD_management.R"
if (file.exists(dev_file)) {
    source(dev_file)
    if (exists("CARD_management")) {
        CARD_management(args=args)
    } else {
        EXstat::CARD_management(args=args) 
    }
} else {
    EXstat::CARD_management(args=args)
}
