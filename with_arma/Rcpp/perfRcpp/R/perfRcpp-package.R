#' @useDynLib perfRcpp, .registration = TRUE
#' @importFrom Rcpp sourceCpp
#' @importFrom methods new
#' @importFrom Rcpp cpp_object_initializer
NULL

# Need to run this first:
# pkgbuild::compile_dll()
# or use
# load_all()
# instead of devtools::document()
