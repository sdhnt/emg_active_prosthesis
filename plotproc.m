clear
clc
load raw2.dat
[n,p] = size(raw2);
t = 1:n;

plot(t,raw2), 
legend('Raw Signal')
xlabel('Time'), ylabel('Raw EMG Value')
title('RAW EMG Signal')