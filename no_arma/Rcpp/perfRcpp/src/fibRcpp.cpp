#include<Rcpp.h>

// here is the cpp code
int fib(int n) {
    return n < 2 ? n : fib(n-1) + fib(n-2);
}


// [[Rcpp::export]]
Rcpp::NumericVector fibRcpp(Rcpp::NumericVector n_){
    double n = Rcpp::as<double> (n_);
    double ans = fib(n);
    return Rcpp::NumericVector::create(ans);
}


