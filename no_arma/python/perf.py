import time
# From https://github.com/JuliaLang/Microbenchmarks/blob/master/perf.py
# https://github.com/JuliaLang/Microbenchmarks


def pisum():
    sum = 0.0
    for j in range(1, 1001):
        sum = 0.0
        for k in range(1, 10001):
            sum += 1.0/(k*k)
    return sum

def fib(n):
    if n<2:
        return n
    return fib(n-1)+fib(n-2)


if __name__=="__main__":
    trials= 21
    filename = "pytimes.txt"
    assert abs(pisum()-1.6448340718480652) < 1e-9
    time_vec = [0.0] * trials
    for i in range(trials):
        t = time.time()
        pi = pisum()
        t = time.time()-t
        time_vec[i] = t
    # get median time
    med_index = int(trials / 2)
    time_vec.sort()
    tmed_pisum = time_vec[med_index]
    print("Python, pisum: ", tmed_pisum, " seconds")
    print(pi)


    assert fib(30) == 832040
    time_vec = [0.0] * trials
    for i in range(trials):
        t = time.time()
        fibnum = fib(30)
        t = time.time()-t
        time_vec[i] = t
    med_index = int(trials / 2)
    time_vec.sort()
    tmed_fib = time_vec[med_index]
    print("Cython, fib: ", tmed_fib, " seconds")
    print(fibnum)


    # write results to file
    f=open(filename,"w+")
    f.write("Python\n")
    f.write("pisum," + str(tmed_pisum) + "\n")
    f.write("fib," + str(tmed_fib) + "\n")
    f.close()

    print("Writing results to: ", filename, "\n")



