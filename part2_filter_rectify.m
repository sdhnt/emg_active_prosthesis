clear
clc
load raw2.dat
rawdat=raw2;
[n,p] = size(rawdat);

t = 1:n;

rect1=abs(rawdat-490);

filteredData=highpass(rect1,0.9);%0.1 is right

rectifiedData= abs(filteredData);


%filteredData1=highpass(rect1,0.9);

%rectifiedData1= abs(filteredData1); % Too much loss of data can show in
%report

%save('check.dat', 'filteredData')


plot(t,rawdat,t, rectifiedData), 
legend('Raw Signal','Filtered & Rectified Signal')
xlabel('Time'), ylabel('EMG Value')
title('RAW vs Filtered & Rectified EMG Signal')