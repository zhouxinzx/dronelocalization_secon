function [return_value]=GM(Node_number,measure_data,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)

Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %测试步长
Room_tag=ones(Room_Length*step,Room_Width*step); %记录房间内点是否符合条件 1为符合 0为不符合
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

 %计算误差
% rmse = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) )
% %