#g++ -std=c++11 -o perfcpp perf.cpp
g++ only_arma_perf.cpp -o only_arma_perf -O2 -larmadillo
./only_arma_perf
