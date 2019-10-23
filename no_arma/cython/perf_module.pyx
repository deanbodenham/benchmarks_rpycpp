# distutils: language = c++

cimport perf_module

def cy_pisum():
    return cpp_pisum()

def cy_fib(n):
    return cpp_fib(n)
