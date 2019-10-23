#include<iostream>

// for std::abs
#include<cmath>

// for timing
#include<chrono>

// for sorting
#include<algorithm>

// for a vector, to sort
#include<vector>

//writing to file
#include<fstream>

// for matrices
#include<armadillo>

// for vectors 
#include<vector>

// don't need this for assert
// #include<cassert>

// Modified from C version here:
// https://github.com/JuliaLang/Microbenchmarks/blob/master/perf.c

double pisum() {
    double sum = 0.0;
    for (int j=0; j<1000; ++j) {
        sum = 0.0;
        for (int k=1; k<=10000; ++k) {
            sum += 1.0/(k*k);
        }
    }
    return sum;
}


int fib(int n) {
    return n < 2 ? n : fib(n-1) + fib(n-2);
}



std::vector<double> randmatstat(int t){
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


int main() {
    int trials = 21;
    int med_index = (int) ( (trials)/2 );
    double pi=0;
    double tmed_pisum=0.0;
    double tmed_fib=0.0;
    double tmed_randmatstat=0.0;
    int f=0;
    double t = 0;
    double s1 = 0.0;
    std::chrono::steady_clock::time_point begin; 
    std::chrono::steady_clock::time_point end; 
    double microconv = 1e-6;
    double ans_pisum = 0;
    int ans_fib = 0;
    double ans_randmatstat = 0.0;
    std::vector<double> time_vec_pisum;
    std::vector<double> time_vec_fib;
    std::vector<double> time_vec_randmatstat;

    // pisum
    for (int i=0; i<trials; ++i) {
        begin = std::chrono::steady_clock::now();
        pi = pisum();
        end = std::chrono::steady_clock::now();
        //convert to microseconds
        t = std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count();
        time_vec_pisum.push_back(t);
    }
    ans_pisum = 1.644834071848065;
    // double ans = 1.6449106278707863;
    assert(   ( std::abs(pi-ans_pisum) < 1e-12 )   );
    //find median
    std::sort(time_vec_pisum.begin(), time_vec_pisum.end());
    tmed_pisum = time_vec_pisum[med_index];
    // time in seconds
    tmed_pisum = tmed_pisum * microconv;
    std::cout << "pisum: " << tmed_pisum << " seconds " << std::endl;


    // Fibonacci
    for (int i=0; i<trials; ++i) {
        begin = std::chrono::steady_clock::now();
        f = fib(42);
        end = std::chrono::steady_clock::now();
        //convert to microseconds
        t = std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count();
        time_vec_fib.push_back(t);
    }
    ans_fib = 832040;
    assert(  f == ans_fib );
    //find median
    std::sort(time_vec_fib.begin(), time_vec_fib.end());
    tmed_fib = time_vec_fib[med_index];
    // time in seconds
    tmed_fib = tmed_fib * microconv;
    std::cout << "fibonnaci: " << tmed_fib << " seconds " << std::endl;
    std::cout << "f: " << f << std::endl;
    
    return 0;
}

