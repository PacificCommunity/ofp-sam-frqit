## FRQIT! - package to appease Rob so we can still get shit done
## Copyright (C) 2020 stolen from Rob Scott by MTVizzle


#' @include FrqClasses.r
NULL

## #'
## #' Accessor methods
## #'
## #' Accessors for extracting and writing data from / to an Frq object.
## #' They are usually named after the slot names of the object class.
## #'
## #' @param object An object of type 'Frq'
## #' @param x An object of type 'Frq'
## #' @param value Replacement value for the replacement methods
## #' @param ... Other arguments
## #' @name accessor-methods

#' @name lf_range
#' @title Get length frequency range
#' @exportMethod lf_range
#' @rdname FrqData
setMethod('lf_range', signature(object='FrqData'),function(object) return(slot(object, 'lf_range')))
#' @name lf_range<-
#' @title give value to length freq range
#' @exportMethod lf_range<-
#' @rdname FrqData
setReplaceMethod('lf_range', signature(object='FrqData', value=unname(getSlots('FrqData')['lf_range'])),
                                function(object, value){slot(object, 'lf_range') <- value; return(object)})
#' @name age_nage
#' @title Get value of unused object in frq
#' @exportMethod age_nage
#' @rdname FrqData
setMethod('age_nage', signature(object='FrqData'),function(object) return(slot(object, 'age_nage')))
#' @name age_nage<-
#' @title Assign value of unused object in frq
#' @exportMethod age_nage<-
#' @rdname FrqData
setReplaceMethod('age_nage', signature(object='FrqData', value=unname(getSlots('FrqData')['age_nage'])),
                                function(object, value){slot(object, 'age_nage') <- value; return(object)})
## #' @name cateffpen
## #' @title Accessor function for the catch effort and penalty in the frq files
## #' @exportMethod cateffpen
## #' @rdname FrqData
setGeneric('cateffpen', function(object, ...) standardGeneric('cateffpen'))
#' @name cateffpen
#' @title Accessor function for the catch effort and penalty in the frq files
#' @exportMethod cateffpen
#' @rdname FrqData
setMethod('cateffpen', signature(object='FrqData'),function(object) return(slot(object, 'cateffpen')))
## #' @name cateffpen<-
## #' @title Assign information to the catch effort pentalty dataframe
## #' @exportMethod cateffpen<-
## #' @rdname FrqData
setGeneric('cateffpen<-', function(object, ..., value) standardGeneric('cateffpen<-'))
#' @name  cateffpen<-
#' @title Assign information to the catch effort pentalty dataframe
#' @exportMethod  cateffpen<-
#' @rdname FrqData
setReplaceMethod('cateffpen', signature(object='FrqData', value=unname(getSlots('FrqData')['cateffpen'])),
                 function(object, value){slot(object, 'cateffpen') <- value; return(object)})
## #' @name lnfrq
## #' @title Get information on length frequency data in frq
## #' @exportMethod lnfrq
## #' @rdname FrqData
setGeneric('lnfrq', function(object, ...) standardGeneric('lnfrq'))
#' @name lnfrq
#' @title Get information on length frequency data in frq
#' @exportMethod lnfrq
#' @rdname FrqData
setMethod('lnfrq', signature(object='FrqData'),function(object) return(slot(object, 'lnfrq')))
## #' @name lnfrq<-
## #' @title Assign information to the length frequency dataframe in the frq object
## #' @exportMethod lnfrq<-
## #' @rdname FrqData
setGeneric('lnfrq<-', function(object, ..., value) standardGeneric('lnfrq<-'))
#' @name lnfrq<-
#' @title Assign information to the length frequency dataframe in the frq object
#' @exportMethod lnfrq<-
#' @rdname FrqData
setReplaceMethod('lnfrq', signature(object='FrqData', value=unname(getSlots('FrqData')['lnfrq'])),
                 function(object, value){slot(object, 'lnfrq') <- value; return(object)})
## #' @name wtfrq
## #' @title Get weight frequency composition data from frq object
## #' @exportMethod wtfrq
## #' @rdname FrqData
setGeneric('wtfrq', function(object, ...) standardGeneric('wtfrq'))
#' @name wtfrq
#' @title Get weight frequency composition data from frq object
#' @exportMethod wtfrq
#' @rdname FrqData
setMethod('wtfrq', signature(object='FrqData'),function(object) return(slot(object, 'wtfrq')))
## #' @name wtfrq<-
## #' @title Assign weight frequency composition data to frq object
## #' @exportMethod wtfrq<-
## #' @rdname FrqData
setGeneric('wtfrq<-', function(object, ..., value) standardGeneric('wtfrq<-'))
#' @name wtfrq<-
#' @title Assign weight frequency composition data to frq object
#' @exportMethod wtfrq<-
#' @rdname FrqData
setReplaceMethod('wtfrq', signature(object='FrqData', value=unname(getSlots('FrqData')['wtfrq'])),
                 function(object, value){slot(object, 'wtfrq') <- value; return(object)})

#############################################################################################################
# class  Frq
#' @name range
#' @title Get Range of frq file
#' @exportMethod range
#' @rdname FrqData
setMethod('range', signature(x='Frq'),function(x) return(slot(x,'range')))
#' @name range<-
#' @title Replace values in range of frq file
#' @exportMethod range<-
#' @rdname FrqData
setReplaceMethod('range', signature(x='Frq', i="missing", value=unname(getSlots('Frq')['range'])),
                 function(x, value){slot(x, 'range') <- value; return(x)})

