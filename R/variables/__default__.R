ASHES$P.var = "var"
ASHES$P.unit = "unit"
ASHES$P.glose = "glose"
ASHES$P.event = "event"

ASHES$P1.funct = NULL
ASHES$P1.funct_args = NULL
ASHES$P1.timeStep = "year"
ASHES$P1.samplePeriod = NULL
ASHES$P1.isDate = FALSE
ASHES$P1.NApct_lim = NULL
ASHES$P1.NAyear_lim = NULL
ASHES$P1.Seasons = c("DJF", "MAM", "JJA", "SON")
ASHES$P1.nameEx = "X"
ASHES$P1.keep = FALSE
ASHES$P1.rmNApct = TRUE

# extract thresold
# sum thresold

# if (!is.null(functT_ext) | !is.null(functT_sum)) {
#     if (!is.null(functT_ext)) {
        
#         df_TEx = do.call(
#             what=extraction_process,
#             args=c(list(data=dataEx,
#                         funct=functT_ext,
#                         period=period,
#                         samplePeriod=samplePeriod,
#                         timeStep=timeStep,
#                         isDate=isDateT_ext,
#                         NApct_lim=NApct_lim,
#                         NAyear_lim=NAyear_lim,
#                         rmNApct=TRUE,
#                         verbose=verbose),
#                    functT_ext_args))
#     } else {
#         df_TEx = dataEx
#     }

#     if (!is.null(functT_sum)) {
#         df_T =
#             dplyr::summarise(
#                        dplyr::group_by(df_TEx, Code),
#                        threshold=
#                            functT_sum(Value,
#                                       !!!functT_sum_args),
#                        .groups="drop")
        
#         names(df_T)[names(df_T) == "threshold"] =
#             names(functY_args)[functY_args == '*threshold*']
#         dataEx = dplyr::full_join(dataEx,
#                                   df_T,
#                                   by="Code")

#         functY_args = functY_args[functY_args != "*threshold*"]
#         if (length(functY_args) == 0) {
#             functY_args = NULL
#         }
#     }
# }
