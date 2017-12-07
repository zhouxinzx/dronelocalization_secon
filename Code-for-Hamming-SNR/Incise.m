function [Room_tag] = Incise(Node_number,measure_data,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)
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
 

%���ݽ����Ϣ������������
xmax=0;
ymax=0;
counter=0;
Room_tag=ones(Room_Length*step,Room_Width*step); %��¼�����ڵ��Ƿ�������� 1Ϊ���� 0Ϊ������
 
for Node_ii=1:Node_number  %��Node_ii�����
	Room_tag_copy=Room_tag;  %BBB�洢����һ�����ָ��AAA����Ϣ
    %�����������䣬�����������ĵ���0
	for x_i=1:Room_Width*step
    	for y_j=1:Room_Length*step
            tmp1=a(Node_ii).*(x_i/step-x0(Node_ii))+b(Node_ii).*(y_j/step-y0(Node_ii));
            if tmp1>0
            	tmp1=1;
            else
                tmp1=0;

            end

            if tmp1~=measure_data(Node_ii)
            	Room_tag(x_i,y_j)=0;
            end

            if(Room_tag(x_i,y_j)==1)
                counter=counter+1; %����ʣ���ĸ���
            end
            % AAA(i,j) 
            % pause;        
        end
    end       

    counter=0;  %��ʼ��������

end