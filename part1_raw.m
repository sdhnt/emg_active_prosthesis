clear
clc
load raw.dat
plotdat=raw;
[n,p] = size(plotdat);

t = 1:n;

plot(t,plotdat), 
legend('Raw Signal')
xlabel('Time'), ylabel('Raw EMG Value')
title('RAW EMG Signal')