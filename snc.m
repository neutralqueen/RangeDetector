function [ y ] = snc( x, n )
%function [ y ] = snc( x, n )
%
%This function takes an input signal x and then converts the number of
%samples by a factor of n, while maintaining its frequency content. This
%synthetically changes the sampling rate of the original signal.

%The following factors are for efficiency and accuracy when using interp
%and decimate for larger magnitudes of n.

defaultorder = 100; %default decimation filter order
samplefactor = 200; %sampling scale factor for fractional sample conversion
maxus = 2; %maximum up sample factor

if(mod(n,1) ~= 0)
    us = ceil(samplefactor*n);
    %Upsample Stage
    A = 1;
    while(A < maxus*us)
        x = interp(x, maxus, 4, 1/maxus);
        A = A*maxus;
    end
    ds = ceil(A/n);
    %Downsample Stage
    x = decimate(x,ds,defaultorder,'fir');
elseif( n > 1)
    x = interp(x, n, 4, 1/n);
else
    x = decimate (x, 1/n, defaultorder, 'fir');
end

y = x;
end

