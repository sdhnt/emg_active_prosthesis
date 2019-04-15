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

smoothedData=smoothdata(rectifiedData,'lowess',90);

%Create own in

origsmooth=smoothedData;

[troughs, indices4]=findpeaks(-smoothedData);
troughs=troughs*-1;
threshold= max(troughs)+0.01;
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
    
    area(i)=trapz(t(range((2*i)-1):range(2*i))  ,smoothedData(range((2*i)-1):range(2*i)));
    %Peak Area - Integrate for each peak and map value to servo
    
end


rangetop=max(findpeaks(smoothedData));
rangebottom=threshold;


plot(t,smoothedData,'-',t,origsmooth,'--'),
findpeaks(smoothedData);

legend('Extracted Motion','Peaks')
xlabel('Time'), ylabel('EMG Signal')
title('Extracted Curve Signal')