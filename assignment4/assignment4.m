% The sampling rate is 200 Hz 
FS = 200;

% Calculate the sample interval from FS
T = 1/FS;

% Load the ECG from the file 'ECG.txt'
ECG = load("ECG.txt");

% Substract the first sample value to prevent P-T to amplify inital step
ECG = ECG-ECG(1);

% Lowpass filter The ECG

%formula from the book:

% H(z) = (1/32)*((((1-z^(-6))^2)/(1-z^(-1))^2))
%y(n) = 2y(n-1)-y(n-2)+1/32[x(n)-2x(n-6)+x(n-12)]
% 1y(n) - 2y(n-1) + 1y(n-2) = 1/32[x(n)-2x(n-6)+x(n-12)]
% josta saadaan a = b ja kertoimista coefficients


b_lowpass = [1 0 0 0 0 0 -2 0 0 0 0 0 1] / 32;
a_lowpass = [1 -2 1];
ECG_filtered1 = filter(b_lowpass,a_lowpass,ECG);

% Highpass filter the lowpass filtered ECG
%formula 4.13 similarly as in previous lowpass filter 

b_highpass = zeros(1,33);
b_highpass(1) = -1;
b_highpass(17) = 32;
b_highpass(18) = -32;
b_highpass(33) = 1;
b_highpass = b_highpass / 32;


a_highpass = [1 -1];
ECG_filtered2 = filter(b_highpass,a_highpass,ECG_filtered1);

% Differential filter the high- and lowpass filtered ECG
b_diff = [1 2 0 -2 -1] / 8;
a_diff = [1];
ECG_filtered3 = filter(b_diff, a_diff, ECG_filtered2);

% Square the derivative filtered signal
ECG_filtered4 = ECG_filtered3 .^2;

% Moving window integrator filter the squared signal
% Window size
N = 30;
b_integ = ones(1,30) / 30;
a_integ = [1];
ECG_filtered5 = filter(b_integ,a_integ,ECG_filtered4);

% Set the blanking interval to 250 ms, but convert it to samples for the findQRS function
blankingInterval = FS/4;

% The amplitude threshold for QRS detection are set to these
treshold1 = 500; 
treshold2 = 2650; 

% Call the findQRS function 
%function provided by course staff
[QRSStart_ECG, QRSEnd_ECG] = findQRS(ECG_filtered5,blankingInterval,treshold1,treshold2);

% Calculate the cumulative filter delays (in samples)
% in ms 25+80 = 105ms -> 0.105 s

delays = 0.105*FS;