# distutils: language = c++

from libcpp.vector cimport vector

cimport perf_module

def cy_pisum():
    return cpp_pisum()

def cy_fib(n):
    return cpp_fib(n)

def cy_randmatstat(t):
    return cpp_randmatstat(t)
