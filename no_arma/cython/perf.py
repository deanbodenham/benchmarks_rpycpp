from perf_module import cy_pisum
from perf_module import cy_fib
import time


if __name__=="__main__":
    filename = "cythontimes.txt"

    trials= 21
    assert abs(cy_pisum()-1.6448340718480652) < 1e-9
    time_vec = [0.0] * trials
    for i in range(trials):
        t = time.time()
        pi = cy_pisum()
        t = time.time()-t
        time_vec[i] = t
    # get median time
    med_index = int(trials / 2)
    time_vec.sort()
    tmed_pisum = time_vec[med_index]
    print("Cython, pisum: ", tmed_pisum, " seconds")
    print(pi)


    assert cy_fib(30) == 832040
    time_vec = [0.0] * trials
    for i in range(trials):
        t = time.time()
        fibnum = cy_fib(30)
        t = time.time()-t
        time_vec[i] = t
    med_index = int(trials / 2)
    time_vec.sort()
    tmed_fib = time_vec[med_index]
    print("Cython, fib: ", tmed_fib, " seconds")
    print(fibnum)


    # write results to file
    f=open(filename,"w+")
    f.write("Cython\n")
    f.write("pisum," + str(tmed_pisum) + "\n")
    f.write("fib," + str(tmed_fib) + "\n")
    f.close()

    print("Writing results to: ", filename, "\n")
