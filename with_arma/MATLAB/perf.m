% from https://github.com/JuliaLang/Microbenchmarks/blob/master/perf.m


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Main function. All the tests are run here.           %%
%%  The functions declarations can be found at the end.  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function perf()
    filename = 'MATLABtimes.csv';
    lang = 'MATLAB';

    fileID = fopen(filename, 'w');
    fprintf(fileID, '%s\n', lang);
    fclose(fileID);
    %fprintf('%s\n', lang)

    %disp("starting pisum MATLAB")
    s = pisum(true);
    assert(abs(s-1.644834071848065) < 1e-9);
    timeit('pisum',@pisum, true)
    %disp("ending pisum MATLAB")


    %disp("starting fib")
    f = fib(30);
	assert(f == 832040)
	timeit('fib', @fib, 20)
    %disp("ending fib MATLAB")

    [s1, s2] = randmatstat(1000);
	assert(round(10*s1) > 5 && round(10*s1) < 10);
	timeit('randmatstat', @randmatstat, 1000)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Functions declarations  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function assert(bool)
   if ~bool
     error('Assertion failed')
   end
end

function timeit(name, func, varargin)
    filename = 'MATLABtimes.csv';

    lang = 'matlab';
    if exist('OCTAVE_VERSION') ~= 0
       lang = 'octave';
    end

    nexpt = 21;
    times = zeros(nexpt, 1);

    for i=1:nexpt
        tic(); func(varargin{:}); times(i) = toc();
    end

    times = sort(times);
    %#fprintf ('%s,%s,%.8f\n', lang, name, times(1)*1000);

    fileID = fopen(filename, 'a+');
    fprintf(fileID, '%s,%.8f\n', name, times(11)*1);
    fclose(fileID);
    %fprintf('%s,%.8f\n', name, times(11)*1000);
end

%% recursive fib %%

function f = fib(n)
    if n < 2
        f = n;
        return
    else
        f = fib(n-1) + fib(n-2);
    end
end


%% slow pi series %%

function sum = pisum(ignore)
    sum = 0.0;
    for j=1:1000
        sum = 0.0;
        for k=1:10000
            sum = sum + 1.0/(k*k);
        end
    end
end


%% random matrix statistics %%

function [s1, s2] = randmatstat(t)
    n=5;
    v = zeros(t,1);
    w = zeros(t,1);
    for i=1:t
        a = randn(n, n);
        b = randn(n, n);
        c = randn(n, n);
        d = randn(n, n);
        P = [a b c d];
        Q = [a b;c d];
        v(i) = trace((P.'*P)^4);
        w(i) = trace((Q.'*Q)^4);
    end
    s1 = std(v)/mean(v);
    s2 = std(w)/mean(w);
end


function t = mytranspose(x)
    [m, n] = size(x);
    t = zeros(n, m);
    for i=1:n
        for j=1:m
            t(i,j) = x(j,i);
        end
    end
end

%% largish random number gen & matmul %%

function X = randmatmul(n)
    X = rand(n,n)*rand(n,n);
end

