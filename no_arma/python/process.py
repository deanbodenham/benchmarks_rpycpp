
if __name__ == "__main__":
    filename = "temp.txt"
    tmed_pisum = 0.023
    tmed_fib = 0.004
    f=open(filename,"w+")
    f.write("py\n")
    f.write("pisum," + str(tmed_pisum) + "\n")
    f.write("fib," + str(tmed_fib) + "\n")
    f.close()
