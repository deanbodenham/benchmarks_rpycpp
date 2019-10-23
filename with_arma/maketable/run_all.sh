# run bash scripts to get times

# running R
echo -e "Running R..."
cd ../R
./run.sh
cd -
echo -e ""

# running python
echo -e "Running Python..."
cd ../python/
./run.sh
cd -
echo -e ""

# running Rcpp
echo -e "Running Rcpp..."
cd ../Rcpp
./run.sh
cd -
echo -e ""

# running cython
echo -e "Running cython..."
cd ../cython/
./runbuild.sh
cd -
echo -e ""

# running cpp
echo -e "Running cpp..."
cd ../cpp
./run.sh
cd -
echo -e ""

# running MATLAB 
echo -e "Running MATLAB..."
cd ../MATLAB
./run.sh
cd -
echo -e ""


# run R script to extract values and print dfs to files
Rscript maketable.R
