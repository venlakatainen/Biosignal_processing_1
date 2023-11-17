% Load problem2.mat to have access to variables abd_sig1 and mhb_ahead
load("problem2.mat");

% The sampling rates are 1000 Hz
FS = 1000;

% Calculate sample timing vector in seconds starting from 0
t = (0:(length(mhb_ahead)-1))*(1/FS);

% Estimate the time lag using cross correlation
% (Calculate cross correlation using the xcorr function and then
% use the max function to find the lag giving maximal correlation)

[xc,lags] = xcorr(abd_sig1,mhb_ahead);

[val,index] = max(xc);

d = lags(index);


% Shift the chest ECG mhb_ahead back in time d samples padding with nearest value

%mhb = mhb_ahead(1:end-d);
%mhb(end+1) = mhb_ahead(length(mhb_ahead)-d);
%mhb(end+1) = mhb_ahead(length(mhb_ahead)-d);

mhb = paddata(mhb_ahead(1:(end-d)), numel(mhb_ahead), Side="leading");

i = mhb_ahead(1);
mhb(1) = i;
mhb(2) = i;

% Estimate c2 from abd_sig1 and mhb
c2 = mhb\abd_sig1;

% Calculate the fetal ECG by cancelling out the scaled mother's ECG using projection based estimation coefficient
fetus = abd_sig1 - (c2*mhb);