% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load("ecg_signal_1.dat");

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load("ecg_signal_2.dat");

% Select the interval [2 s, 3s] samples from ECG 1
ecg1_interval = ecg1(2000:3000);

% Sample times for the interval 1
ecg1_interval_t = [2:(1/FS):3];

% Select the interval [1 s, 2s] samples from ECG 2
ecg2_interval = ecg2(1000:2000);

% Sample times for the interval 2
ecg2_interval_t = [1:(1/FS):2];

% Compute ECG 1 power spectrum
P_ecg1 = (1/8568)*fft(ecg1).*conj(fft(ecg1));

% Compute ECG 2 power spectrum
P_ecg2 = (1/9519)*fft(ecg2).*conj(fft(ecg2));

% Compute power spectrum frequency bins from 0 Hz to the Nyquist frequency
% Nyquist frequency FS/2 = 500 Hz
% step = FS/length of FFT
% how many steps will fit in to the range 0-500
% For ECG 1
step=FS/8568;
f1 = linspace(0,500,500/(FS/8568)+1);
% ...and for ECG 2
f2 = linspace(0,500,500/(FS/9519)+1);


% Create moving average filter coefficients a and b:
b_average = ones(1,10)/10;
a_average = [1];
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered_average = filter(b,a,ecg1);
% ...and ecg2
ecg2_filtered_average = filter(b,a,ecg2);


% Create derivative based filter coefficients a and b:
b_deriv = [1 -1];
a_deriv = [1 -0.995];

[h,w] = freqz(b_deriv,a_deriv,FS);

b_deriv = (1/real(max([h])))*b_deriv;
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered_derivative = filter(b_deriv,a_deriv,ecg1);
% ...and ecg2
ecg2_filtered_derivative = filter(b_deriv,a_deriv,ecg2);



% Create comb filter coefficients a and b:

b_comb = [0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310];
a_comb = 1;
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered_comb = filter(b,a,ecg1);
% ...and ecg2
ecg2_filtered_comb = filter(b,a,ecg2);


% Create cascaded filter coefficients a and b using convolution

b_avg = ones(1,10)/10;
a_avg = [1];

b_deriv = [1 -1];
a_deriv = [1 -0.995];

[h,w] = freqz(b_deriv,a_deriv,FS);

b_deriv = (1/real(max([h])))*b_deriv;

b_comb_4 = [0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310];
a_comb_4 = 1;


b = conv(conv(b_avg,b_deriv),b_comb_4);
a = conv(conv(a_avg,a_deriv),a_comb_4);
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered = filter(b,a,ecg1);
% ...and ecg2
ecg2_filtered = filter(b,a,ecg2);