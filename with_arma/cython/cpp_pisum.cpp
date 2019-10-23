double cpp_pisum() {
    double sum = 0.0;
    for (int j=0; j<1000; ++j) {
        sum = 0.0;
        for (int k=1; k<=10000; ++k) {
            sum += 1.0/(k*k);
        }
    }
    return sum;
}
