// for matrices
#include<armadillo>

// for vector
#include<vector>

std::vector<double> cpp_randmatstat(int t){
    int n = 5;
    arma::mat v = arma::zeros<arma::mat>(t, 1);
    arma::mat w = arma::zeros<arma::mat>(t, 1);
    for (int i = 0; i < t; ++i){
        arma::mat a = arma::randn(n,n);
        arma::mat b = arma::randn(n,n);
        arma::mat c = arma::randn(n,n);
        arma::mat d = arma::randn(n,n);
        arma::mat P = arma::join_vert<arma::mat>( arma::join_vert<arma::mat>(a, b), 
                                                  arma::join_vert<arma::mat>(c, d) );
        arma::mat Q = arma::join_horiz<arma::mat>( arma::join_vert<arma::mat>(a, b), 
                                                   arma::join_vert<arma::mat>(c, d) );
        v(i) = arma::accu(   arma::diagvec(  arma::pow( P.t() * P, 4 )  )   ); 
        w(i) = arma::accu(   arma::diagvec(  arma::pow( Q.t() * Q, 4 )  )   ); 
    }
    arma::vec s1 = arma::stddev(v, 0)/arma::mean(v);
    arma::vec s2 = arma::stddev(w, 0)/arma::mean(w);
    std::vector<double> s1and2;
    s1and2.push_back( s1(0) );
    s1and2.push_back( s2(0) );
    return s1and2;
}
