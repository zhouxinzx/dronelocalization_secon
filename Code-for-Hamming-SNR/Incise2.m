function [Room_tag] = Incise2(Node_number,measure_data,measure_data_probability,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)
Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %���Բ���
%%�ֻ�����λ��Microphone_Center_Location
Microphone_Center_Location=(Microphone_1_Location+Microphone_2_Location)/2;
%����ʸ��Direct_vector
Mic_vector=Microphone_1_Location-Microphone_2_Location;
a=Mic_vector(1:end,1);
b=Mic_vector(1:end,2);
x0=Microphone_Center_Location(1:end,1);
y0=Microphone_Center_Location(1:end,2); 

Room_tag=zeros(Room_Length*step,Room_Width*step); %��¼�����ڵ��Ƿ�������� 1Ϊ���� 0Ϊ������ 
for Node_ii=1:Node_number  %��Node_ii�����
	    %�����������䣬�����������ĵ���0
	for x_i=1:Room_Width*step
    	for y_j=1:Room_Length*step
               tmp11=a(Node_ii).*(x_i/step-x0(Node_ii))+b(Node_ii).*(y_j/step-y0(Node_ii)); 
             if tmp11>0
             	tmp11=1;
             else 
             	%tmp11=-1;
             	tmp11=0;
             end
 
             if tmp11==measure_data(Node_ii)
             	Room_tag(x_i,y_j)=Room_tag(x_i,y_j)+ measure_data_probability(Node_ii);
             else 
                Room_tag(x_i,y_j)=Room_tag(x_i,y_j)+ 1-measure_data_probability(Node_ii);
             end
 
        end
    end       
end
end

