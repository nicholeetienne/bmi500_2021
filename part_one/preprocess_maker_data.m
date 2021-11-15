%Nichole Etienne 
%BMI 500 
%preprocess_marker_data
%Butterworth filter design from https://www.mathworks.com/help/signal/ref/butter.html


function outcome = preprocess_marker_data(raw_data,time,cutoff_frequency)

%Butterworth filter design
sampling_frequency = 1/mean(diff(time));
[b,a] = butter(2,cutoff_frequency/(sampling_frequency/2));
outcome=filtfilt(b,a,raw_data);