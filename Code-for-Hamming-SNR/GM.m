function [return_value]=GM(Node_number,measure_data,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %���Բ���
Room_tag=ones(Room_Length*step,Room_Width*step); %��¼�����ڵ��Ƿ�������� 1Ϊ���� 0Ϊ������
Room_tag=Incise(Node_number,measure_data,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale);
[x,y]=Coordinate(Room_tag,Size_Grid,scale); 

xx=1:Room_Width*step;
xx=xx./step;
yy=1:Room_Width*step;
yy=yy./step;
[X,Y]=meshgrid(xx,yy);
Z=Room_tag;


estimated_location=[x y];
return_value=estimated_location;

 %�������
% rmse = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) )
% %