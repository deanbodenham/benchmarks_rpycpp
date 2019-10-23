cdef extern from  "cpp_pisum.cpp": 
    double cpp_pisum()

cdef extern from  "cpp_fib.cpp": 
    int cpp_fib(int)
