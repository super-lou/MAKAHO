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
                    help="CARD directory.")
parser$add_argument('-t', '--tmp', type="character",
                    default="",
                    help="CARD analyse temporary writing directory.")
parser$add_argument('-l', '--layout', nargs='+', type="character",
                    default="EX [ QA ]",
                    help="Layout of the chosen variables.")
parser$add_argument("-w", "--white", action="store_true", default=TRUE,
                    help="Underscores in directory names are replace by white spaces")
parser$add_argument("-b", "--blank", action="store_true", default=FALSE,
                    help="Remove id before variable names")
parser$add_argument("-o", "--overwrite", action="store_true", default=TRUE,
                    help="Overwrites CARD dir")
parser$add_argument("-v", "--verbose", action="store_true", default=FALSE,
                    help="Print information")

args = parser$parse_args()

# print(args$l)
# args$l = c("A", "[", "a", "[", "aa", "[", "aaa", "bbb", "]", "bb", "[", "ccc", "ddd", "]", "]", "b", "[", "aa", "[", "aaa", "]", "]", "]")


# source("/home/louis/Documents/bouleau/INRAE/project/EXstat_project/EXstat/R/CARD_management.R")
# if (exists("CARD_management")) {
    CARD_management(args=args)
# } else {
    # EXstat::CARD_management(args=args)
# }
# warnings()
