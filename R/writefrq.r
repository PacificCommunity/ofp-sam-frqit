## FRQIT! - package to appease Rob so we can still get shit done
## Copyright (C) 2020 stolen from Rob Scott by MTVizzle

#' Function to write a Frq object to file
#'
#' @param x object of class
#' @param file path and name of file to be written
#' @param append whether to add to the end of the file or overwrite
#'
#' @examples
#' writefrq(frq,"skj.frq")
#'
#' @export
setGeneric('writefrq', function(x,...) standardGeneric('writefrq'))
setMethod("writefrq", signature(x="Frq"), function(x, file, append=F, ...){

    if(file.exists(file) && append==F)
        file.remove(file)
    if(!file.exists(file))
        file.create(file)

    cat("# \n# Definition of fisheries \n# \n", file=file, append=T)
    cat("# Number of   Number of   Use generic   Number of     Year1 \n",  file=file, append=T)
    cat("#  Region     Fisheries    diffusion    tag groups \n", file=file, append=T)
    cat(paste(paste0('\t  ',n_regions(x)), n_fisheries(x), as.numeric(generic_diffusion(x)), n_tag_groups(x), sep='\t\t\t '), file=file, append=T)
    cat(paste("\t\t ", range(x)['minyear'], "0", as.numeric(frq_age_len(x)), n_recs_yr(x), rec_month(x), frq_version(x), '\n', sep="\t"), file=file, append=T)
    cat("# Relative Region Size \n", file=file, append=T)
    write.table(matrix(region_size(x),nrow=1), file=file, append=T, col.names=F, row.names=F)
    cat("#\n# Region in which each fishery is located \n", file=file, append=T)
    write.table(t(matrix(region_fish(x))), file=file, append=T, col.names=F, row.names=F)
    cat("#\n# \n# Incidence matrix \n", file=file, append=T)
    write.table(move_matrix(x), file=file, append=T, col.names=F, row.names=F, na=" ")
    cat("#\n# \n# Data flags (for records 1, 0=catch in number; 1=catch in weight) \n", file=file, append=T)
    write.table(data_flags(x), file=file, append=T, col.names=F, row.names=F)
                                        #  if(n_regions(x)>1){
    cat("# Season-region flags \n", file=file, append=T)
    write.table(season_flags(x), file=file, append=T, col.names=F, row.names=F)
                                        #  }
    cat("# Number of movements per year \n", file=file, append=T)
    cat(paste(n_move_yr(x), "\n"), file=file, append=T)
    cat("# Weeks in which movement occurs \n", file=file, append=T)
    write.table(matrix(move_weeks(x),nrow=1), file=file, append=T, col.names=F, row.names=F)

    ## End of head stuff now to write all of the data

    cat("# fishery data \n# \n# \n", file=file, append=T)
    cat("# Datasets / LFIntervals  LFFirst  LFWidth  LFFactor / WFIntervals  WFFirst  WFWidth \n",file=file, append=T)
    ## Automatically set the number of datasets to the length of the output freq ragged array
    lf_range(x)["Datasets"]=dim(unique(cateffpen(x)[,1:4]))[1]
    cat(paste(as.vector(lf_range(x)), collapse="      "), file=file, append=T)
    cat("\n# age_nage   age_age1 \n", file=file, append=T)
    cat(paste(paste(as.vector(age_nage(x)), collapse="      "),"\n"), file=file, append=T)

    ## check for duplicate entries in all three dataframes
    if (any(duplicated(cateffpen(x)[,1:4]))) stop("There was a duplicate in the catch effort and penalty data frame")
    if (any(duplicated(lnfrq(x)[,1:4]))) stop("There was a duplicate in the length frequency data frame")
    if (any(duplicated(wtfrq(x)[,1:4]))) stop("There was a duplicate in the weight frequency data frame")

    cep=cateffpen(x)
    lnfrq=lnfrq(x)
    wtfrq=wtfrq(x)

    ## Remove any rows that are all zeros from the length and weight frequency data frames
    if(dim(lnfrq)[1]>0) lnfrq=lnfrq[!apply(lnfrq[,-4:-1]==0,1,all),]
    if(dim(wtfrq)[1]>0) wtfrq=wtfrq[!apply(wtfrq[,-4:-1]==0,1,all),]

    LnMatcher=match(interaction(lnfrq[,1:4]),interaction(cep[,1:4]),nomatch=0)
    if(any(LnMatcher==0)) warning("There are entries in the length composition data frame that aren't in the catch effort penalty data frame")
    WtMatcher=match(interaction(wtfrq[,1:4]),interaction(cep[,1:4]),nomatch=0)
    if(any(WtMatcher==0)) warning("There are entries in the weight composition data frame that aren't in the catch effort penalty data frame")


    NoMatch=!(1:dim(cep)[1]%in%c(LnMatcher,WtMatcher))
    Lfirst=lf_range(x)['LFFirst']
    Wfirst=lf_range(x)["WFFirst"]

    if(length(LnMatcher)>0&Lfirst==0) warning("You have length bins that will be printed but the lf_range says you shouldn't")
    if(length(WtMatcher)>0&Wfirst==0) warning("You have weight bins that will be printed but the lf_range says you shouldn't")

    output=apply(cep,1,paste,collapse=' ')
    ## No Length or weight
    if (length(NoMatch>0))
        output[NoMatch]=paste(output[NoMatch],ifelse(Lfirst==0,"","-1"),ifelse(Wfirst==0,"","-1"),sep=' ')

    ## Length only
    if (length(LnMatcher[!(LnMatcher%in%WtMatcher)])>0)
        output[LnMatcher[!(LnMatcher%in%WtMatcher)]]=paste(output[LnMatcher[!(LnMatcher%in%WtMatcher)]], apply(lnfrq[!(LnMatcher%in%WtMatcher),-4:-1],1,paste,collapse=' '),ifelse(Wfirst==0,"","-1"),sep=' ')

    ## Weight only
    if (length(WtMatcher[!(WtMatcher%in%LnMatcher)])>0)
        output[WtMatcher[!(WtMatcher%in%LnMatcher)]]=paste(output[WtMatcher[!(WtMatcher%in%LnMatcher)]],ifelse(Lfirst==0,"","-1"), apply(wtfrq[!(WtMatcher%in%LnMatcher),-4:-1],1,paste,collapse=' '),sep=' ')

    ## Length and weight
    if (length(WtMatcher[WtMatcher%in%LnMatcher])>0)
        output[WtMatcher[WtMatcher%in%LnMatcher]]=paste(output[WtMatcher[WtMatcher%in%LnMatcher]], apply(lnfrq[LnMatcher%in%WtMatcher,-4:-1],1,paste,collapse=' '), apply(wtfrq[WtMatcher%in%LnMatcher,-4:-1],1,paste,collapse=' '),sep=' ')


    cat(output,file=file,sep="\n",append=TRUE)

}
)
