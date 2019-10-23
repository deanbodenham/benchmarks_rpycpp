cdef extern from  "cpp_pisum.cpp": 
    double cpp_pisum()

cdef extern from  "cpp_fib.cpp": 
    int cpp_fib(int)

from libcpp.vector cimport vector

cdef extern from  "cpp_randmatstat.cpp": 
    vector[double] cpp_randmatstat(int)
