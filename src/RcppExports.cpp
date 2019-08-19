// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <RcppArmadillo.h>
#include <Rcpp.h>

using namespace Rcpp;

// mse
IntegerMatrix mse(List adjList, IntegerVector deg);
RcppExport SEXP _igraphUtils_mse(SEXP adjListSEXP, SEXP degSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< List >::type adjList(adjListSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type deg(degSEXP);
    rcpp_result_gen = Rcpp::wrap(mse(adjList, deg));
    return rcpp_result_gen;
END_RCPP
}
// sortxy
IntegerVector sortxy(IntegerVector x, IntegerVector y);
RcppExport SEXP _igraphUtils_sortxy(SEXP xSEXP, SEXP ySEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type y(ySEXP);
    rcpp_result_gen = Rcpp::wrap(sortxy(x, y));
    return rcpp_result_gen;
END_RCPP
}
// triadCensusCol
IntegerVector triadCensusCol(const arma::sp_mat& A, IntegerVector attr, IntegerMatrix orbitClasses, IntegerVector triads);
RcppExport SEXP _igraphUtils_triadCensusCol(SEXP ASEXP, SEXP attrSEXP, SEXP orbitClassesSEXP, SEXP triadsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const arma::sp_mat& >::type A(ASEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type attr(attrSEXP);
    Rcpp::traits::input_parameter< IntegerMatrix >::type orbitClasses(orbitClassesSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type triads(triadsSEXP);
    rcpp_result_gen = Rcpp::wrap(triadCensusCol(A, attr, orbitClasses, triads));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_igraphUtils_mse", (DL_FUNC) &_igraphUtils_mse, 2},
    {"_igraphUtils_sortxy", (DL_FUNC) &_igraphUtils_sortxy, 2},
    {"_igraphUtils_triadCensusCol", (DL_FUNC) &_igraphUtils_triadCensusCol, 4},
    {NULL, NULL, 0}
};

RcppExport void R_init_igraphUtils(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
