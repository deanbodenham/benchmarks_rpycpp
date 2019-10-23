int cpp_fib(int n) {
    return n < 2 ? n : cpp_fib(n-1) + cpp_fib(n-2);
}
