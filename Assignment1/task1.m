% Load the data/variables from the file named spirometer.txt
spiro = load("spirometer.txt");

%plot(spiro)

% The spirometer data 'spiro' is a 2Nx1 vector
% Resample the spirometer data into 50 Hz
% function resample, first variable signal, second variable to 
% which Hz data wanted to resampled and third from what Hz
spiro_resampled = resample(spiro,5,10);

save spiro_resampled.mat spiro_resampled