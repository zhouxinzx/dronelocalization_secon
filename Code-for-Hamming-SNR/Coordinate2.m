function [x,y]=Coordinate2(Room_tag,Size_Grid,scale)

Room_Length=Size_Grid;
Room_Width=Size_Grid; 
step=scale;  %���Բ���
xmax=0;
ymax=0;
max=0;
x=0;
y=0;


 %��������ʣ�������ļ����е㣬��Ϊ��λ������
for x_i=1:Room_Width*step
	for y_j=1:Room_Length*step
	
        if Room_tag(x_i,y_j)==max
            counter=counter+1;
            xmax=xmax+x_i/step;
            ymax=ymax+y_j/step;
        end
		
        if Room_tag(x_i,y_j)>max
            
            counter=1;
            max=Room_tag(x_i,y_j);
           % max
            xmax=x_i/step;
            ymax=y_j/step;

        end
    end
end


 %��ʣ������Ϊ0���÷����е���棬
if counter==0
	disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Coordinate2 counter==0!!!!!!!!!!!!!!!!!!!!!!!!!!')
		disp('localization fault��')
    x=NaN;
    y=NaN;  
else
    x=xmax/counter;
    y=ymax/counter;
end

end