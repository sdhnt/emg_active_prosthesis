%Integration and servo position mapping

%Smoothing of data (save the final plots)

clear
clc
load raw.dat
rawdat=raw;

[n,p] = size(rawdat);

t = 1:n;

rect1=abs(rawdat-490);

filteredData=highpass(rect1,0.1);

rectifiedData= abs(filteredData);


%filteredData1=highpass(rect1,0.9);

%rectifiedData1= abs(filteredData1); % Too much loss of data can show in
%report

%We want smooth (continuous), noise free but preserve data

%smoothedData=smoothdata(rectifiedData,'movmean',30);%30 gives nice value
%smoothedData=smoothdata(rectifiedData,'gaussian',50);%50 give us the value
smoothedData=smoothdata(rectifiedData,'lowess',90);%Computational Expensive - not in real time - 40 is good value
%smoothedData=abs(smoothdata(rectifiedData,'sgolay',50));%

%Create own in

origsmooth=smoothedData;

[troughs, indices4]=findpeaks(-smoothedData);
troughs=troughs*-1;
threshold= max(troughs)+0.1;
indices = find(abs(smoothedData)<threshold);
indices2 = find(abs(smoothedData)>threshold);
smoothedData(indices) = 0;
[pks,indices3]=findpeaks(smoothedData);


area = size(indices3);
range = 2*size(indices3);%Range Sets (x limits)
ctr=1;
prevval=0;

for j=1:n
    currentval=smoothedData(j);
    
    if (smoothedData(j)==0)
        if(prevval~=0)
            range(ctr)=j; ctr=ctr+1;
        end
    else
        if(prevval==0) 
            range(ctr)=j; ctr=ctr+1;
        end
        
    end
    prevval=currentval;
    
    
end


for i = 1:((ctr-1)/2)
    
    area(i)=trapz(t(range((2*i)-1):range(2*i)), smoothedData(range((2*i)-1):range(2*i)))     ;%Peak Area - Integrate for each peak and map value to servo
    
end


rangetop=max(area);
rangebottom=threshold;

scaleFactor=rangetop/90.0;

servoPos=area/scaleFactor;

ctr1=1;

servoTable= zeros((i*3),2);

for k = 1:i
    
    servoTable(ctr1,2)=0;
    servoTable(ctr1+1,2)=servoPos(k);
    servoTable(ctr1+2,2)=0;
    servoTable(ctr1,1)=range(2*k-1);
    servoTable(ctr1+1,1)=indices3(k);
    servoTable(ctr1+2,1)=range(2*k);
    ctr1=ctr1+3;
    
end

temp1=servoTable(:,1)';
temp2=servoTable(:,2)';

xx = 0:0.1:n;
%yy = spline(servoTable(:,1),servoTable(:,2),xx);
yy = pchip(temp1,temp2,xx);

indix = find(yy<0);
yy(indix)=0;

yy=floor(yy);


fileID=fopen('servomap.txt','w');
fprintf(fileID,'%f\n',yy);
fclose(fileID);



figure
subplot(3,1,3);
plot(t,rawdat), 
legend('Raw Signal')
xlabel('Time'), ylabel('Raw EMG Value')
title('RAW EMG Signal')

subplot(3,1,2);
plot(xx,yy)

legend('Servo Position')
xlabel('Time'), ylabel('Servo Angle')
title('Servo Position for EMG Signal')




subplot(3,1,1);
plot(t,smoothedData,'-',t,origsmooth,'--'),

legend('Extracted Motion','Smoothed Data')
xlabel('Time'), ylabel('EMG Signal')
title('Smoothed EMG Signal')