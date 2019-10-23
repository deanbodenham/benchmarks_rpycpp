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
