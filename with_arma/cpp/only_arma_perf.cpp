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

    

    // randmatstat
    std::vector<double> s1and2;
    for (int i=0; i<trials; ++i) {
        begin = std::chrono::steady_clock::now();
        s1and2 = randmatstat(1000);
        end = std::chrono::steady_clock::now();
        //convert to microseconds
        t = std::chrono::duration_cast<std::chrono::microseconds>(end-begin).count();
        time_vec_randmatstat.push_back(t);
    }
    ans_randmatstat = 0.5;
    s1 = s1and2[0];
    // double ans = 1.6449106278707863;
    assert(  s1 > ans_randmatstat );
    //find median
    std::sort(time_vec_randmatstat.begin(), time_vec_randmatstat.end());
    tmed_randmatstat = time_vec_randmatstat[med_index];
    // time in seconds
    tmed_randmatstat = tmed_randmatstat * microconv;
    std::cout << "randmatstat: " << tmed_randmatstat << " seconds " << std::endl;
// 
    //write results to file
    std::ofstream csvfile;
    csvfile.open("cpptimes.csv", std::ios_base::app);
    csvfile << "randmatstat," << tmed_randmatstat << "\n";
    csvfile.close();
    std::cout << "Writing to file" << std::endl;

    return 0;
}

