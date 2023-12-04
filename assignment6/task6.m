% Load the data from the file 'data6.mat'
% << INSERT YOUR CODE HERE >>
load('data6.mat', 'data');

% The ECG sampling rate is 1000 Hz
FS = 1000;

% QRS detector operates on 200 Hz signals
FS_QRS = 200;

% The number of subjects
N = numel(data);

% Windowing length
window = 50;

% Number of overlapped samples 
nbroverlap = 45;

% Specify nfft parameter as empty. 
nfft = [];

% Minimum spectrogram threshold
th = -30; 

% Using the pre-extracted cardiac cycles (struct 'cycles'), compute the spectrogram for each subject
% Store the results in a similar 1xN struct array called 'SPCs' with the fields s, f, t, and p corresponding to the outputs of the function 'spectrogram'
% E.g. SPCs(3).p is the power spectral density spectrogram (a matrix) of the subject 3.
[s1,f1,t1,p1] = spectrogram(cycles(1).PCG,hamming(window),nbroverlap,nfft,FS,'yaxis','MinThreshold',-30);
[s2,f2,t2,p2] = spectrogram(cycles(2).PCG,hamming(window),nbroverlap,nfft,FS,'yaxis','MinThreshold',-30);
[s3,f3,t3,p3] = spectrogram(cycles(3).PCG,hamming(window),nbroverlap,nfft,FS,'yaxis','MinThreshold',-30);
[s4,f4,t4,p4] = spectrogram(cycles(4).PCG,hamming(window),nbroverlap,nfft,FS,'yaxis','MinThreshold',-30);
[s5,f5,t5,p5] = spectrogram(cycles(5).PCG,hamming(window),nbroverlap,nfft,FS,'yaxis','MinThreshold',-30);

SPCs = struct('s',{s1,s2,s3,s4,s5},'f',{f1,f2,f3,f4,f5},'t',{t1,t2,t3,t4,t5},'p',{p1,p2,p3,p4,p5});

% Using the full data (struct 'data'), find the QRS complexes using the function 'QRSDetection'
% Store only the QRS onset indice vectors of each subject in the elements of the 1xN cell array 'onsets'
% Note: QRS detection works at a lower data rate of 200 Hz instead of 1000 Hz, so you must resample the data first
%       Also you must map the detected onsets back to the original sampling rate by multiplying with the correct factor

resampled1 = resample(data(1).ECG,2,10);
[QRSOnsets1, QRSOffsets1] = QRSDetection(resampled1); 

resampled2 = resample(data(2).ECG,2,10);
[QRSOnsets2, QRSOffsets2] = QRSDetection(resampled2);

resampled3 = resample(data(3).ECG,2,10);
[QRSOnsets3, QRSOffsets3] = QRSDetection(resampled3);

resampled4 = resample(data(4).ECG,2,10);
[QRSOnsets4, QRSOffsets4] = QRSDetection(resampled4);

resampled5 = resample(data(5).ECG,2,10);
[QRSOnsets5, QRSOffsets5] = QRSDetection(resampled5);

onsets = {[QRSOnsets1]*5, [QRSOnsets2]*5, [QRSOnsets3]*5, [QRSOnsets4]*5, [QRSOnsets5]*5};

% The systolic part of the PCG signal is expected to span this many samples starting from the QRS onset in each beat
segment_length = 300;

% Using the previously computed onsets, for each subject 
% pick all their PCG segments corresponding to the systolic parts in a 1xN cell array 'systoles'
% So, each cell corresponds to a subject, and contains a m-by-segment_length sized matrix of their m PCG segments

% systoles 1
systoles1 = [];
segment_samples = [];
onset1 = [QRSOnsets1]*5;
pcg1 = data(1).PCG;

%loop through first patient onsets

for onset = 1:length(onset1)
    segment_samples = [];
    segment = onset;
    %loop through first patien pcg signal
    for sample = 1:length(pcg1);
        
        %compare if the signal sample correspond the onset
        if sample == onset1(onset);
            
            %take 300 next samples to the segment
            segment_samples(end+1) = pcg1(sample);
            
            for next_sample = 1:299
                
                segment_samples(end+1) = pcg1(sample+next_sample);
                
            end
            
        end
    end
    systoles1 = [systoles1; segment_samples];
    
end


% systoles 2
systoles2 = [];
segment_samples = [];
onset2 = [QRSOnsets2]*5;
pcg2 = data(2).PCG;

%loop through first patient onsets

for onset = 1:length(onset2)
    segment_samples = [];
    segment = onset;
    %loop through first patien pcg signal
    for sample = 1:length(pcg2);
        
        %compare if the signal sample correspond the onset
        if sample == onset2(onset);
            
            %take 300 next samples to the segment
            segment_samples(end+1) = pcg2(sample);
            
            for next_sample = 1:299
                
                segment_samples(end+1) = pcg2(sample+next_sample);
                
            end
            
        end
    end
    systoles2 = [systoles2; segment_samples];
    
end



% systoles 3
systoles3 = [];
segment_samples = [];
onset3 = [QRSOnsets3]*5;
pcg3 = data(3).PCG;

%loop through first patient onsets

for onset = 1:length(onset3)
    segment_samples = [];
    segment = onset;
    %loop through first patien pcg signal
    for sample = 1:length(pcg3);
        
        %compare if the signal sample correspond the onset
        if sample == onset3(onset);
            
            %take 300 next samples to the segment
            segment_samples(end+1) = pcg3(sample);
            
            for next_sample = 1:299
                
                segment_samples(end+1) = pcg3(sample+next_sample);
                
            end
            
        end
    end
    systoles3 = [systoles3; segment_samples];
    
end


% systoles 4
systoles4 = [];
segment_samples = [];
onset4 = [QRSOnsets4]*5;
pcg4 = data(4).PCG;

%loop through first patient onsets

for onset = 1:length(onset4)
    segment_samples = [];
    segment = onset;
    %loop through first patien pcg signal
    for sample = 1:length(pcg4);
        
        %compare if the signal sample correspond the onset
        if sample == onset4(onset);
            
            %take 300 next samples to the segment
            segment_samples(end+1) = pcg4(sample);
            
            for next_sample = 1:299
                
                segment_samples(end+1) = pcg4(sample+next_sample);
                
            end
            
        end
    end
    systoles4 = [systoles4; segment_samples];
    
end



% systoles 5
systoles5 = [];
segment_samples = [];
onset5 = [QRSOnsets5]*5;
pcg5 = data(5).PCG;

%loop through first patient onsets

for onset = 1:length(onset5)
    segment_samples = [];
    segment = onset;
    %loop through first patien pcg signal
    for sample = 1:length(pcg5);
        
        %compare if the signal sample correspond the onset
        if sample == onset5(onset);
            
            %take 300 next samples to the segment
            segment_samples(end+1) = pcg5(sample);
            
            for next_sample = 1:299
                
                segment_samples(end+1) = pcg5(sample+next_sample);
                
            end
            
        end
    end
    systoles5 = [systoles5; segment_samples];
    
end



systoles = {systoles1, systoles2, systoles3, systoles4, systoles5};

% For each subject, compute the power spectral density (PSD) of all the PCG segments separately
% Use the 'pwelch' function with the default arguments but specifying the sampling rate
% Store the results in a 1xN struct array 'PSDs' with the fields Pxx and F corresponding to the outputs of the pwelch function
% In addition, add the field Pxx_mean which is the average of all the PSD of that subject averaged across the beats
% Thus, PSDs(i).Pxx is a mxk matrix, PSDs(i).F is a kx1 vector, and PSDs(i).Pxx_mean is a 1xk vector
window = [];
noverlap = [];
f = [];

%PSD1
PSDs1 = [];
PSDs1_pxx=[];
PSDs1_f=[];

for segment = 1:size(systoles1,1)
    x = systoles1(segment,:);
    [pxx,f] = pwelch(x,window,noverlap,nfft,FS);
    PSDs1_pxx = [PSDs1_pxx; transpose(pxx)];
    PSDs1_f = [PSDs1_f; f];
end

mean_1 = mean(PSDs1_pxx);
[pxx,PSDs1_f] = pwelch(systoles1,window,noverlap,nfft,FS);


%PSD2
PSDs2 = [];
PSDs2_pxx=[];
PSDs2_f=[];

for segment = 1:size(systoles2,1)
    x = systoles2(segment,:);
    [pxx,f] = pwelch(x,window,noverlap,nfft,FS);
    PSDs2_pxx = [PSDs2_pxx; transpose(pxx)];
    PSDs2_f = [PSDs2_f; f];
end

mean_2 = mean(PSDs2_pxx);
[pxx,PSDs2_f] = pwelch(systoles2,window,noverlap,nfft,FS);


%PSD3
PSDs3 = [];
PSDs3_pxx=[];
PSDs3_f=[];

for segment = 1:size(systoles3,1)
    x = systoles3(segment,:);
    [pxx,f] = pwelch(x,window,noverlap,nfft,FS);
    PSDs3_pxx = [PSDs3_pxx; transpose(pxx)];
    PSDs3_f = [PSDs3_f; f];
end

mean_3 = mean(PSDs3_pxx);
[pxx,PSDs3_f] = pwelch(systoles3,window,noverlap,nfft,FS);


%PSD4
PSDs4 = [];
PSDs4_pxx=[];
PSDs4_f=[];

for segment = 1:size(systoles4,1)
    x = systoles4(segment,:);
    [pxx,f] = pwelch(x,window,noverlap,nfft,FS);
    PSDs4_pxx = [PSDs4_pxx; transpose(pxx)];
    PSDs4_f = [PSDs4_f; f];
end

mean_4 = mean(PSDs4_pxx);
[pxx,PSDs4_f] = pwelch(systoles4,window,noverlap,nfft,FS);


%PSD5
PSDs5 = [];
PSDs5_pxx=[];
PSDs5_f=[];

for segment = 1:size(systoles5,1)
    x = systoles5(segment,:);
    [pxx,f] = pwelch(x,window,noverlap,nfft,FS);
    PSDs5_pxx = [PSDs5_pxx; transpose(pxx)];
    PSDs5_f = [PSDs5_f; f];
end

mean_5 = mean(PSDs5_pxx);
[pxx,PSDs5_f] = pwelch(systoles5,window,noverlap,nfft,FS);

PSDs = struct('Pxx',{PSDs1_pxx, PSDs2_pxx, PSDs3_pxx, PSDs4_pxx, PSDs5_pxx},'F',{PSDs1_f, PSDs2_f, PSDs3_f, PSDs4_f, PSDs5_f},'Pxx_mean',{mean_1,mean_2,mean_3,mean_4,mean_5});
