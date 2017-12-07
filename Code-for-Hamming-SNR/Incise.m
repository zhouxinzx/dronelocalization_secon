function [Room_tag] = Incise(Node_number,measure_data,Microphone_Center_Location,Microphone_Distance,Mic_vector,Microphone_1_Location,Microphone_2_Location,Size_Grid,scale)
Room_Width=Size_Grid;
Room_Length=Size_Grid;
 
step=scale;  %测试步长
%%手机中心位置Microphone_Center_Location
Microphone_Center_Location=(Microphone_1_Location+Microphone_2_Location)/2;
%方向矢量Direct_vector
Mic_vector=Microphone_1_Location-Microphone_2_Location;
a=Mic_vector(1:end,1);
b=Mic_vector(1:end,2);
x0=Microphone_Center_Location(1:end,1);
y0=Microphone_Center_Location(1:end,2); 
 

%根据结点信息遍历整个房间
xmax=0;
ymax=0;
counter=0;
Room_tag=ones(Room_Length*step,Room_Width*step); %记录房间内点是否符合条件 1为符合 0为不符合
 
for Node_ii=1:Node_number  %第Node_ii个结点
	Room_tag_copy=Room_tag;  %BBB存储经上一个结点分割后AAA的信息
    %遍历整个房间，不符合条件的点置0
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
                counter=counter+1; %计数剩余点的个数
            end
            % AAA(i,j) 
            % pause;        
        end
    end       

    counter=0;  %初始化计数器

end