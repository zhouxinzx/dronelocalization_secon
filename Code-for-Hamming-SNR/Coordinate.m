function [x,y]=Coordinate(Room_tag,Size_Grid,scale)
Room_Length=Size_Grid;
Room_Width=Size_Grid; 
step=scale;  %���Բ���
%��������ʣ�������ļ����е㣬��Ϊ��λ������
counter=0;
xmax=0;
ymax=0;
for x_i=1:Room_Width*step
	for y_j=1:Room_Length*step
        if Room_tag(x_i,y_j)==1
            xmax=xmax+x_i/step;
            ymax=ymax+y_j/step;
            counter=counter+1;
        end
    end
end
 %counter_is_zero=0;
 
 %��ʣ������Ϊ0���÷����е���棬
if counter==0
	disp('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!counter==0!!!!!!!!!!!!!!!!!!!!!!!!!!')
    x=NaN;
    y=NaN;   
else
    x=xmax/counter;
    y=ymax/counter;
end
end