function Dh = hammingDist(B1, B2)
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
    
    counter = counter + abs(B1(i)-B2(i));
end    
    Dh=counter;







