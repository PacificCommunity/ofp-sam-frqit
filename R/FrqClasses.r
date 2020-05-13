## FRQIT! - package to appease Rob so we can still get shit done
## Copyright (C) 2020 stolen from Rob Scott by MTVizzle


###### CLASSS FrqData  (from .frq file)

validFrqData <- function(object){
    ##Everything is fine
    return(TRUE)
}
#' An S4 class : Length frequency information from the frq file.
#'
#' @slot lf_range Range information of the length frequencies
#' @slot age_nage I don't know what this is but it's in the frq file
#' @slot cateffpen Data frame of catch effort and penalty information.
#' @slot lnfrq Data frame of length frequency information.
#' @slot wtfrq Data frame of weight frequency information.
setClass("FrqData",
         representation(
             lf_range    ="numeric",
             age_nage    ="numeric",
             cateffpen    ="data.frame",
             lnfrq        ="data.frame",
             wtfrq        ="data.frame"
         ),
         prototype=prototype(
             lf_range     =unlist(list(Datasets=0,LFIntervals=NA,LFFirst=NA,LFWidth=NA,LFFactor=NA,WFIntervals=NA,WFFirst=NA,WFWidth=NA,WFFactor=NA)),
             age_nage     =unlist(list(age_nage=0,age_age1=NA)),
             cateffpen     =data.frame(),
             lnfrq         =data.frame(),
             wtfrq         =data.frame()
         ),
         validity=validFrqData
         )
setValidity("FrqData", validFrqData)
remove(validFrqData)
##createMFCLAccesors("FrqData")
#'FrqData
#'
#'Basic constructor for FrqData class
#'@export
 FrqData <- function() {return(new("FrqData"))}


###### CLASSS Frq  --- a better frq object

validFrq <- function(object){

                                        # Everything is fine
    return(TRUE)
}
#' An S4 class : Representation of a frq input file for MFCL
#'
#' A class comprising an MFCLFrqStats object and an MFCLLenFrq object
#'
setClass("Frq",
         representation(
             "MFCLFrqStats",
             "FrqData"
         ),
         validity=validFrq
         )
setValidity("Frq", validFrq)
remove(validFrq)

#' Frq
#'
#'Basic constructor for Frq class
#'
#'@export

Frq <- function() {return(new("Frq"))}

