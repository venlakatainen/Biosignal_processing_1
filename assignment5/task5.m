% The sampling rate is 2000 Hz 
FS = 2000;

% Load the signals from data.mat into the struct 'data'
% << insert loading code here >>
load('data.mat', 'data');

% Number of segments
N = numel(data);  

% Calculate average force of each segment (1xN vector)
AF = [mean(data(1).force) mean(data(2).force) mean(data(3).force) mean(data(4).force) mean(data(5).force)];

% Calculate EMG dynamic range in each segment (1xN vector)

DR_1 = max(data(1).EMG) - min(data(1).EMG);
DR_2 = max(data(2).EMG) - min(data(2).EMG);
DR_3 = max(data(3).EMG) - min(data(3).EMG);
DR_4 = max(data(4).EMG) - min(data(4).EMG);
DR_5 = max(data(5).EMG) - min(data(5).EMG);
DR = [DR_1 DR_2 DR_3 DR_4 DR_5];

% Calculate EMG mean squared value in each segment (1xN vector)
MS_1 = (1/data(1).length)*sum(data(1).EMG.^2);
MS_2 = (1/data(2).length)*sum(data(2).EMG.^2);
MS_3 = (1/data(3).length)*sum(data(3).EMG.^2);
MS_4 = (1/data(4).length)*sum(data(4).EMG.^2);
MS_5 = (1/data(5).length)*sum(data(5).EMG.^2);


MS = [MS_1 MS_2 MS_3 MS_4 MS_5];

% Calculate EMG zero crossing rate in each segment (1xN vector)

% ZCR segment 1
sign_1 = sign(data(1).EMG);

numb_value = sign_1(1);
ZCR_1 = 0;

for numb = 1:length(sign_1)
    if (sign_1(numb) ~= numb_value)
        ZCR_1 = ZCR_1 + 1;
        numb_value = sign_1(numb);
    end
end

% ZCR segment 2
sign_2 = sign(data(2).EMG);

numb_value = sign_2(1);
ZCR_2 = 0;

for numb = 1:length(sign_2)
    if (sign_2(numb) ~= numb_value)
        ZCR_2 = ZCR_2 + 1;
        numb_value = sign_2(numb);
    end
end

% ZCR segment 3
sign_3 = sign(data(3).EMG);

numb_value = sign_3(1);
ZCR_3 = 0;

for numb = 1:length(sign_3)
    if (sign_3(numb) ~= numb_value)
        ZCR_3 = ZCR_3 + 1;
        numb_value = sign_3(numb);
    end
end

% ZCR segment 4
sign_4 = sign(data(4).EMG);

numb_value = sign_4(1);
ZCR_4 = 0;

for numb = 1:length(sign_4)
    if (sign_4(numb) ~= numb_value)
        ZCR_4 = ZCR_4 + 1;
        numb_value = sign_4(numb);
    end
end

% ZCR segment 5
sign_5 = sign(data(5).EMG);

numb_value = sign_5(1);
ZCR_5 = 0;

for numb = 1:length(sign_5)
    if (sign_5(numb) ~= numb_value)
        ZCR_5 = ZCR_5 + 1;
        numb_value = sign_5(numb);
    end
end

% time duration

time_1 = data(1).length/FS;
time_2 = data(2).length/FS;
time_3 = data(3).length/FS;
time_4 = data(4).length/FS;
time_5 = data(5).length/FS;

ZCR = [ZCR_1/time_1 ZCR_2/time_2 ZCR_3/time_3 ZCR_4/time_4 ZCR_5/time_5];


% Calculate EMG turns rate in each segment (1xN vector)

% derivative of the EMG signal

diff_1 = diff(data(1).EMG);

diff_2 = diff(data(2).EMG);

diff_3 = diff(data(3).EMG);

diff_4 = diff(data(4).EMG);

diff_5 = diff(data(5).EMG);

% Detect the points of change in its sign

diff_sig_1 = sign(diff_1);

diff_sig_2 = sign(diff_2);

diff_sig_3 = sign(diff_3);

diff_sig_4 = sign(diff_4);

diff_sig_5 = sign(diff_5);

% TCRs

% TCR segment 1

numb_value = diff_sig_1(1);
numb_prev = 1;
TCR_1 = 0;

for numb = 1:length(diff_sig_1)
    if (diff_sig_1(numb) ~= numb_value)
        
        numb_value = diff_sig_1(numb);
        
        if (abs(data(1).EMG(numb)-data(1).EMG(numb_prev)) >= 0.1)
            TCR_1 = TCR_1 + 1;
 
        end
        
        numb_prev = numb;
    end
end

% TCR segment 2

numb_value = diff_sig_2(1);
numb_prev = 1;
TCR_2 = 0;

for numb = 1:length(diff_sig_2)
    if (diff_sig_2(numb) ~= numb_value)
        
        numb_value = diff_sig_2(numb);
        
        if (abs(data(2).EMG(numb)-data(2).EMG(numb_prev)) >= 0.1)
            TCR_2 = TCR_2 + 1;
 
        end
        
        numb_prev = numb;
    end
end

% TCR segment 3

numb_value = diff_sig_3(1);
numb_prev = 1;
TCR_3 = 0;

for numb = 1:length(diff_sig_3)
    if (diff_sig_3(numb) ~= numb_value)
        
        numb_value = diff_sig_3(numb);
        
        if (abs(data(3).EMG(numb)-data(3).EMG(numb_prev)) >= 0.1)
            TCR_3 = TCR_3 + 1;
 
        end
        
        numb_prev = numb;
    end
end

% TCR segment 4

numb_value = diff_sig_4(1);
numb_prev = 1;
TCR_4 = 0;

for numb = 1:length(diff_sig_4)
    if (diff_sig_4(numb) ~= numb_value)
        
        numb_value = diff_sig_4(numb);
        
        if (abs(data(4).EMG(numb)-data(4).EMG(numb_prev)) >= 0.1)
            TCR_4 = TCR_4 + 1;
 
        end
        
        numb_prev = numb;
    end
end

% TCR segment 5

numb_value = diff_sig_5(1);
numb_prev = 1;
TCR_5 = 0;
turns = [];

for numb = 1:length(diff_sig_5)
    if (diff_sig_5(numb) ~= numb_value)
        
        numb_value = diff_sig_5(numb);
        
        if (abs(data(5).EMG(numb)-data(5).EMG(numb_prev)) >= 0.1)
            TCR_5 = TCR_5 + 1;
 
        end
        
        numb_prev = numb;
    end
end

%turns;

%emg = data(5).EMG;
%t = data(5).t;
%figure; 
%hold on;
%plot(t, emg);  % the EMG signal
%plot(t(turns), emg(turns), 'r*');  % the turn points in the signal


TCR = [TCR_1/time_1 TCR_2/time_2 TCR_3/time_3 TCR_4/time_4 TCR_5/time_5];

% Calculate the linear model coefficients for each parameter
% The models are in the form: parameter(force) = constant + slope * force,
% and the coefficients are stored in a 1x2 vectors: p_<param> = [slope constant]
% For example, p_DR(1) is the slope and p_DR(2) is the constant of the linear model mapping the average force into the dynamic range
% You can use the 'polyfit' (or the 'regress') command(s) to find the model coefficients

% from the cheat sheet
% x: values of independent variable
% y: values of dependent variable
%polynom_coeffs = polyfit(x, y, degree)
%y_estimate = polyval(polynom_coeffs, x)

p_DR = polyfit(AF, DR, 3);
y_estimate_dr = polyval(p_DR,AF);


p_MS = polyfit(AF, MS, 4);
y_estimate_MS = polyval(p_MS, AF);


p_ZCR = polyfit(AF, ZCR, 4);
y_estimate_ZCR = polyval(p_ZCR, AF);


p_TCR = polyfit(AF, TCR, 4);
y_estimate_TCR = polyval(p_TCR, AF);



% Calculate correlation coefficients between the average forces and each of the parameters using 'corr'
c_DR = corr(transpose(AF), transpose(y_estimate_dr));
c_MS = corr(transpose(AF), transpose(y_estimate_MS));
c_ZCR = corr(transpose(AF), transpose(y_estimate_ZCR));
c_TCR = corr(transpose(AF), transpose(y_estimate_TCR)); 
