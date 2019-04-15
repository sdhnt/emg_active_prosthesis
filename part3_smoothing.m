%Smoothing of data (save the final plots)

clear
clc
load raw2.dat
rawdat=raw2;
[n,p] = size(rawdat);

t = 1:n;

rect1=abs(rawdat-490);

filteredData=highpass(rect1,0.1);

rectifiedData= abs(filteredData);

%We want smooth (continuous), noise free but preserve data

%smoothedData=smoothdata(rectifiedData,'movmean',10);
%30 is a good value
smoothedData=smoothdata(rectifiedData,'sgolay',30);
smoothedData1=smoothdata(rectifiedData,'sgolay',50);
smoothedData2=smoothdata(rectifiedData,'sgolay',70);
%50 is a goof value
%smoothedData=smoothdata(rectifiedData,'lowess',40);%Computational Expensive
%40 is good value
%smoothedData=abs(smoothdata(rectifiedData,'sgolay',50));
%50 is a good value 

figure
subplot(3,1,3);

plot(t,rectifiedData,':',t, smoothedData,'-'), 
legend('Filtered Signal','Smoothed Data@30')
xlabel('Time'), ylabel('EMG Value')
title('Smoothed EMG Signal (S-Golay 30 points)')

subplot(3,1,2);

plot(t,rectifiedData,':',t, smoothedData1,'-'), 
legend('Filtered Signal','Smoothed Data@50')
xlabel('Time'), ylabel('EMG Value')
title('Smoothed EMG Signal (S-Golay 50 points)')



subplot(3,1,1);

plot(t,rectifiedData,':',t, smoothedData2,'-'), 
legend('Filtered Signal','Smoothed Data@70')
xlabel('Time'), ylabel('EMG Value')
title('Smoothed EMG Signal (S-Golay 70 points)')
