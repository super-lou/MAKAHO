


word = function (id) {
    w = dico[[language]][dico$id == id]
    return (w)
}

create_dico = function (dico_file, resources_path) {
    dico_path = file.path(resources_path, dico_file)
    dico = tibble(read.table(dico_path, header=TRUE, sep=";"))
    for (j in 1:ncol(dico)) {
        dico[j] = as.character(dico[[j]])
    }
    return (dico)
}

get_listVar = function () {
    OkPhe = as.vector(regexpr("var[0-9]$", dico[[1]])) != -1
    IdPhe = which(OkPhe)
    nbPhe = sum(as.numeric(OkPhe))

    OkNumVar = as.vector(regexpr("var[0-9].[0-9]$", dico[[1]]))
    nbVar = with(rle(OkNumVar), lengths[values == 1])

    listIdVar = list()

    for (i in 1:nbPhe) {
        nbVar_phe = nbVar[i]
        sub_listIdVar = list()
        
        for (j in 1:nbVar_phe) {
            sub_listIdVar = append(sub_listIdVar,
                                   word(paste0("var", i, "." , j)))
        }
        listIdVar = append(listIdVar, list(sub_listIdVar))
        names(listIdVar)[length(listIdVar)] = word(paste0("var", i))
    } 
    return (listIdVar)
}

get_urlTile = function (theme, provider, theme_file, resources_path) {
    
    theme_path = file.path(resources_path, theme_file)
    urlTiles = as.character(read.table(file=theme_path,
                                       header=FALSE,
                                       quote='"')[[1]])
        
    OkProvider = grepl(provider, urlTiles, fixed=TRUE)
    urlTiles_provider = urlTiles[OkProvider]

    # print(theme == )
    
    if (provider == "jawg") {
        if (theme == word("r.theme.light")) {
            themeUrl = 'light'
        } else if (theme == word("r.theme.ter")) {
            themeUrl = 'terrain'
        } else if (theme == word("r.theme.dark")) {
            themeUrl = 'dark'
        }
    }

    OkTheme = grepl(themeUrl, urlTiles_provider, fixed=TRUE)
    urlTile = urlTiles_provider[OkTheme]
    
    if (provider == "jawg") {
        token =
            "hEjAgwvvpEJBpIR62stbJUflOVZXM73MoB1hQGAR69fCtoNVQiHJOKp8lVlPOdFH"
        urlTile = sub("[{]accessToken[}]", token, urlTile)
    } else {
        stop("error")
    }
    return (urlTile)
}

# get_urlTile(word("r.theme.light"), 'jawg', 'theme.txt', resources_path)


get_icon = function (icon_dir, resources_path) {
    # icon_file = paste0(name, '.svg')
    iconLib = icon_set(file.path(resources_path, icon_dir))#, icon_file))
    return (iconLib)
}

actionButtonI = function (inputId, label, icon_name, width=NULL, ...){
    actionButton(inputId,
                 div(label,
                     style="float:right;padding-left:3px;"),
                 icon=NULL,
                 width=width,
                 img(icon_name, align="right"),
                 ...)
}


read_FST = function (resdir, filename, filedir='fst') {
    outfile = file.path(resdir, filedir, filename)
    df = tibble(fst::read_fst(outfile))
    return (df)
}


# df_data = read_FST(computer_data_path, 'data_QMNA_01.fst', filedir='fst')
# df_meta = read_FST(computer_data_path, 'meta.fst', filedir='fst')


