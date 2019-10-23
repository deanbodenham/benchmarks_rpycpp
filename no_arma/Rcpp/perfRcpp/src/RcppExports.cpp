// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// fibRcpp
Rcpp::NumericVector fibRcpp(Rcpp::NumericVector n_);
RcppExport SEXP _perfRcpp_fibRcpp(SEXP n_SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::NumericVector >::type n_(n_SEXP);
    rcpp_result_gen = Rcpp::wrap(fibRcpp(n_));
    return rcpp_result_gen;
END_RCPP
}
// pisumRcpp
Rcpp::NumericVector pisumRcpp();
RcppExport SEXP _perfRcpp_pisumRcpp() {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    rcpp_result_gen = Rcpp::wrap(pisumRcpp());
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_perfRcpp_fibRcpp", (DL_FUNC) &_perfRcpp_fibRcpp, 1},
    {"_perfRcpp_pisumRcpp", (DL_FUNC) &_perfRcpp_pisumRcpp, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_perfRcpp(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
