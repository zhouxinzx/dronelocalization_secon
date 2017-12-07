 function return_value=Hamming_Distance_Method(measure_data,Hashing_table,KNN)
 
 [m,n]=size(Hashing_table);
 
 data_length=length(measure_data);
 
 
 if data_length~=(n-2)
    return_value=[0,0];
	 data_length
	 n-2
    disp('Hamming_Distance_Method error!!');
    pause;
    return;
 end
 
 weight=zeros(m,1);
 for i=1:m     
    tmp= Hashing_table(i,1:n-2);
%     weight(i)=hammingDist(measure_data, tmp)*measure_data_probability(i);
    weight(i)=hammingDist(measure_data, tmp);
 end


[value,index]=sort(weight,'ascend');
% value(1:10)'
% pause;
%%ȡ��С��KNN��
near_neibor=KNN;
iindex=index(1:near_neibor);

%iindex=index(1);  %%ȡ��С��

for i=1:length(iindex)
	xx(i)=Hashing_table(iindex(i),n-1);
    yy(i)=Hashing_table(iindex(i),n);
end

x=mean(xx);
y=mean(yy);


% �ҳ����е���Сֵ����Ӧ����ȡ��ֵ��
return_value=[x, y];

