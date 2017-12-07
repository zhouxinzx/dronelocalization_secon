function [table_binary]=creat_table(Microphone_Center_Location,Microphone_Cita,Microphone_Distance,Room_Width,Room_Length,scale,Node_number)

 table_binary=zeros(Room_Width*scale*Room_Width*scale,Node_number+2);	

      Microphone_1_Location=zeros(Node_number,2);
		Microphone_2_Location=zeros(Node_number,2);
		
        for  i=1:Node_number
        %%(L/2,0)
	    Microphone_1_Location(i,1)=Microphone_Center_Location(i,1) + 0.5*Microphone_Distance*(cos(Microphone_Cita(i)*pi/180));
        Microphone_1_Location(i,2)=Microphone_Center_Location(i,2) + 0.5*Microphone_Distance*(-sin(Microphone_Cita(i)*pi/180));  
		 %%(-L/2,0)
        Microphone_2_Location(i,1)=Microphone_Center_Location(i,1) - 0.5*Microphone_Distance*(cos(Microphone_Cita(i)*pi/180));
        Microphone_2_Location(i,2)=Microphone_Center_Location(i,2) - 0.5*Microphone_Distance*(-sin(Microphone_Cita(i)*pi/180));        
        end
 
		Mic_vector=Microphone_1_Location-Microphone_2_Location;
        a_tmp=Mic_vector(1:end,1);
        b_tmp=Mic_vector(1:end,2);
        x0_tmp=Microphone_Center_Location(1:end,1);
        y0_tmp=Microphone_Center_Location(1:end,2);	
        count_tmp=0;
        for x_i=1:Room_Width*scale
            for y_j=1:Room_Length*scale
                count_tmp = count_tmp+1;
                speaker_x=x_i/scale;
                speaker_y=y_j/scale;
                tmp=a_tmp.*(speaker_x-x0_tmp)+b_tmp.*(speaker_y-y0_tmp);
                measure_data_tmp=zeros(Node_number,1);  
                for i=1:Node_number
                    if tmp(i)>0
                        measure_data_tmp(i)=1;
                    else
                        measure_data_tmp(i)=0;
                    end
                end
                table_binary(count_tmp,:)=[measure_data_tmp;speaker_x;speaker_y];         
            end
        end 