% Load the data from the file problem3.mat


% Nx1 vectors flow1, flow2, and flow3 contain the model predictions
% Nx1 vector spiro_resampled contains the resampled reference spirometer data

flow1 = load("flow1.mat");
flow2 = load("flow2.mat");
flow3 = load("flow3.mat");

% Compute the correlation coefficient for the model 1, between flow1 and spiro_resampled
corr1 = corr(flow1.flow1,spiro_resampled.spiro_resampled);

% Compute the correlation coefficient for the model 2, between flow2 and spiro_resampled
corr2 = corr(flow2.flow2,spiro_resampled.spiro_resampled);

% Compute the correlation coefficient for the model 3, between flow3 and spiro_resampled
corr3 = corr(flow3.flow3,spiro_resampled.spiro_resampled);

% Compute the RMSE for the model 1, between flow1 and spiro_resampled
rmse1 = rmse(flow1.flow1,spiro_resampled.spiro_resampled);

% Compute the RMSE for the model 2, between flow2 and spiro_resampled
rmse2 = rmse(flow2.flow2,spiro_resampled.spiro_resampled);

% Compute the RMSE for the model 3, between flow3 and spiro_resampled
rmse3 = rmse(flow3.flow3,spiro_resampled.spiro_resampled);

% This is the version returned in the mathworks grader
% % Load the data from the file problem3.mat
% 
% load("problem3.mat")
% 
% % Nx1 vectors flow1, flow2, and flow3 contain the model predictions
% % Nx1 vector spiro_resampled contains the resampled reference spirometer data
% 
% % Compute the correlation coefficient for the model 1, between flow1 and spiro_resampled
% corr1 = corr(flow1,spiro_resampled);
% 
% % Compute the correlation coefficient for the model 2, between flow2 and spiro_resampled
% corr2 = corr(flow2,spiro_resampled);
% 
% % Compute the correlation coefficient for the model 3, between flow3 and spiro_resampled
% corr3 = corr(flow3,spiro_resampled);
% 
% % Compute the RMSE for the model 1, between flow1 and spiro_resampled
% rmse1 = rmse(flow1,spiro_resampled);
% 
% % Compute the RMSE for the model 2, between flow2 and spiro_resampled
% rmse2 = rmse(flow2,spiro_resampled);
% 
% % Compute the RMSE for the model 3, between flow3 and spiro_resampled
% rmse3 = rmse(flow3,spiro_resampled);