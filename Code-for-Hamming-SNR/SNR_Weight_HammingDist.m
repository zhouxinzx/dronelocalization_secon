function Dh = SNR_Weight_HammingDist(B1, B2, SNR)

%%SNR--0-10


for i=1:length(SNR)
weigth(i)=1-exp(-SNR(i));
end



[m1,n1]=size(B1);
[m2,n2]=size(B2);

NN1=max(m1,n1); %%%length
NN2=max(m2,n2);

if NN1~=NN2
 disp('error');
 Dh=10000;
end    

len=NN1;


counter=0;

for i=1:len
%    if B1(i)~=B2(i)
%      counter=counter+1;  
%    end
    
    counter = counter + abs(B1(i)-B2(i))*weigth(i);
end    
    Dh=counter;







