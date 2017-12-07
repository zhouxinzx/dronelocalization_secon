 function return_value=SNR_Weight_Hamming_Distance_Method(measure_data,Hashing_table,SNR)
 [m,n]=size(Hashing_table);
 num_discret_point=m;

 data_length=length(measure_data);
 Node_num=data_length;
 
 if data_length~=(n-2)
    return_value=[0,0];
	 data_length
	 n-2
    disp('Hamming_Distance_Method error!!');
    pause;
    return;
 end
 
 weight=zeros(m,1);
 sigma=Node_num/30;  %%%%%���������½��ٶȣ�sigmaԽС������Խ����
 for i=1:num_discret_point    
    tmp= Hashing_table(i,1:n-2);
	
hd=SNR_Weight_HammingDist(measure_data, tmp,SNR);

	weight(i)= exp(-hd*hd/2/sigma/sigma)/sqrt(2*pi)/sigma;
 end




%Ȩֵ��һ��
sum_weight=sum(weight);

for i=1:num_discret_point    
weight_regular(i)=weight(i)/sum_weight;
end


x=0;
y=0;
for i=1:num_discret_point
	x=x + weight_regular(i)*Hashing_table(i,n-1);
    y=y + weight_regular(i)*Hashing_table(i,n);
end





% �ҳ����е���Сֵ����Ӧ����ȡ��ֵ��
return_value=[x, y];

