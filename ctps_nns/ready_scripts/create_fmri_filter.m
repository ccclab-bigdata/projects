function [ b ] = create_fmri_filter( TR )
%CREATE_FMRI_FILTER Summary of this function goes here
%   Detailed explanation goes here
A=[0 1 0];
Fs=1/TR; % sampling frequency of 0.5 Hz
F=[0.025 0.04 0.07 0.09];  % pass-band of 0.04-0.07 Hz. In resting state they use a lot 0.01-0.08 Hz. For that case you can put F=[0.0 0.01 0.08 0.09];
DEV=[0.05 0.01 0.05];  % error deviation (stopband - inband - stopband) 0.05 is ~ -40db. Check the firpmord matlab function help or the book by Oppenheim Schafer "Discrete-Time Signal Processing"

[N,Fo,Ao,W] = firpmord(F,A,DEV,Fs);

if(mod(N,2)==1)
    N=N+1;  % it has to be even -> b is odd -> delay is integer = N/2  % useful if you use the function 'filter' or 'conv' so that you can compensate the delay
end

% NOTE: if N is too high, e.g. comparable to 1/3 the length of the time series, then change those 0.05 to something more relaxed like 0.1 OR increase the passband and/or transition band.

b=firpm(N,Fo,Ao,W); % this is the filter impulse response

% % If you want to visualize the filter frequency response
% freqz(b,1,N,Fs)

% finally we apply the filter to a timeseries variable named ts
% I use filtfilt instead of filter to get 0-phase delay and twice the stopband power. Check the filtfilt function


end

