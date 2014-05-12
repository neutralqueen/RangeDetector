function [ Error ] = testsnc(f)
%function [ Error ] = testsnc(f)
%
%testsnc is shorthand for test sample number converter. This function tests
%the sample number converter function, whose purpose is to convert the
%total number of samples in one signal into a different number of samples
%without changing the frequency content by much (percent yet to be
%defined).

Error = [];

Td = 1e-3; %signal duration
Fs1 = 1e6;  %original sampling frequency 
Fs2 = 2e6;  %desired upsampling frequency
Fs3 = 0.5e6;    %desired downsampling frequency
Fs4 = 1.5e6;
Fs5 = 0.7e6;
t1 = linspace(0,Td,Td*Fs1);
t2 = linspace(0,Td,Td*Fs2);
t3 = linspace(0,Td,Td*Fs3);
t4 = linspace(0,Td,Td*Fs4);
t5 = linspace(0,Td,Td*Fs5);
f1 = 50e3;  %signal frequency
Xt1 = cos(2*pi*f1*t1);  %original sample set
Xt2 = cos(2*pi*f1*t2);  %desired integer upsample set
Xt3 = cos(2*pi*f1*t3);  %desired integer downsample set
Xt4 = cos(2*pi*f1*t4);  %desired noninteger upsample set
Xt5 = cos(2*pi*f1*t5);  %desired noninteger downsample set
%Test 1 
%determines if function exists
try
    Yt1 = f(Xt1,2);
    Yt2 = f(Xt1,0.5);
    Yt3 = f(Xt1,3/2);
    Yt4 = f(Xt1,7/10);
catch err
    Error = [1];
    Yt1 = 0;
end

%Test 2
%determines if function output has correct length
if(length(Yt1) ~= length(Xt2))
    Error = [Error,2];
elseif(length(Yt2) ~= length(Xt3))
    Error = [Error,2];
elseif(length(Yt3) ~= length(Xt4))
    Error = [Error,2];
elseif(length(Yt4) ~= length(Xt5))
    Error = [Error,2];
end

%Test 3 
%determines if the function's output signal is not distorted after integer
%up conversion
try
    A = corr(Yt1', Xt2');
    if(A < 0.95)
        Error = [Error,3];
    end
catch err
   Error = [Error,3]; 
end

%Test 4
%determines if the function's output signal is not distorted after integer
%down conversion
try
    A = corr( Yt2', Xt3');
    if(A < 0.95)
        Error = [Error,4];
    end
catch err
     Error = [Error,4];
end

%Test 5 
%determines if the function's output signal is not distorted after
%noninteger up conversion
try
    A = corr(Yt3', Xt4');
    if(A < 0.95)
        Error = [Error,5];
    end
catch err
   Error = [Error,4]; 
end

%Test 6
%determines if the function's output signal is not distorted after 
%noninteger down conversion
try
    A = corr( Yt4', Xt5');
    if(A < 0.95)
        Error = [Error,6];
    end
catch err
     Error = [Error,6];
end



end

