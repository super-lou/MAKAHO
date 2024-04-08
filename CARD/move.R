Paths = list.files("./",
                   pattern=".*[.]R$",
                   full.names=TRUE,
                   recursive=TRUE)

Paths = Paths[!grepl("move", Paths)]

new_dir = "move"
unlink(new_dir, recursive=TRUE)
dir.create(new_dir)

for (path in Paths) {
    lines = readLines(path)
    is_en = grepl("P[.].*[_]en", lines)
    is_fr = grepl("P[.].*[_]fr", lines)
    is_P = grepl("P[.]", lines) & !is_en & !is_fr
    block_en = lines[is_en]
    block_fr = lines[is_fr]
    block_P = lines[is_P]

    allPX = stringr::str_extract(lines, "P[[:digit:]]")
    allPX = allPX[!duplicated(allPX)]
    allPX = allPX[!is.na(allPX)]

    block_PX = c()
    for (PX in allPX) {
        is_PX = grepl(PX, lines)
        block_PX = c(block_PX,
                     paste0("### ", PX, " _______________________________________________________________"),
                     lines[is_PX], "")
    }
    
    lines = c(
"#   ___                _ 
#  / __| __ _  _ _  __| |
# | (__ / _` || '_|/ _` |
#  \\___|\\__,_||_|  \\__,_|
# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1
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
# If not, see <https://www.gnu.org/licenses/>.", "", "",
"## INFO ______________________________________________________________",
"### English __________________________________________________________",
block_en, "",
"### French ___________________________________________________________",
block_fr, "",
"### Global ___________________________________________________________",
block_P, "", "",
"## PROCESS ___________________________________________________________",
block_PX)

    output_path = file.path(new_dir, sub("[.]", "", path))
    output_dir = file.path(new_dir, sub("[.]", "", dirname(path)))
    if (!dir.exists(output_dir)) {
        dir.create(output_dir, recursive=TRUE)
    }
    writeLines(lines, output_path)
}

#   ___                _ 
#  / __| __ _  _ _  __| |
# | (__ / _` || '_|/ _` |
#  \___|\__,_||_|  \__,_|
# Copyright 2022-2024 Louis Héraut (louis.heraut@inrae.fr)*1
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

## INFO ______________________________________________________________
### English __________________________________________________________
### French ___________________________________________________________
### Global ___________________________________________________________

## PROCESS ___________________________________________________________
### P1 _______________________________________________________________
