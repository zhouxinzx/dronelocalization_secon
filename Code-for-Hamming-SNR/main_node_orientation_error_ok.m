% main function
clc;
clear all  %��� 
close all; %�ر�֮ǰ����

Size_Grid=10;  %�����С����λ��m 
Room_Length=Size_Grid; %���䳤��
Room_Width=Size_Grid;  %������
RUNS = 100; %%�������
scale=5;        %%%%%%%%%%%%%%%%%%%%%%%%%%%%�ɱ������GM�㷨�Ŀռ���ɢ������
Microphone_Distance=0.2; %�ֻ�������mic֮�����
measure_alpha=0.75;     %%%�и����
percent             = 0.9;      %���㶨λ���ʱ��ֻȡǰ90%���������10%
KNN=4;  %% Basic Hamming parameter ��Hamming������С��KNN����ȡƽ��

location_error_range_abs = 0.05;         %%%%%%%%%%%%%%%%%%%%�ڵ�λ����Χ,��λm
%angle_error_range_abs = 5;            %%%%%%%%%%%%%%%%%%%�ڵ�Ƕ���Χ,��λ�Ƕ�
Node_Error_NUM_Percent=0.1; %%%%%%%%%%%%%%%%%%%�ڵ�������Ϣ����İٷֱ�
real_statics_run=floor(RUNS*percent);
   
Node_number=50;

anchor_min=0;   %��С�ڵ�ָ�����
anchor_max=10;  %���
anchor_gap=1;   %���
anchors=anchor_min:anchor_gap:anchor_max;  %%%%%%%%%%%%%%%%%%%%%%%%%%�ɱ������ʵ����ʹ�õĽ�����



for runs = 1:RUNS 
disp(['--------------------------------------------------------- ']);
    disp(['runs = ',num2str(runs)]);
	disp(['--------------------------------------------------------- ']);
     
    count=1;
     
    for Num_Achohor=anchor_min:anchor_gap:anchor_max
        angle_error_range_abs =  Num_Achohor;
             disp(['angle_error = ',num2str(angle_error_range_abs)]);
	disp(['************* ']); 
        Microphone_Cita=fix(-90+180*(rand(Node_number,1))); %%���� [-90  90]    
         Microphone_Center_Location=fix(Size_Grid*abs((rand(Node_number,2)))); % ���� λ��
       
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
        
%       for  i=1:Node_number  
% plot(Microphone_1_Location(i,1),Microphone_1_Location(i,2),'r.',Microphone_2_Location(i,1),Microphone_2_Location(i,2),'r.',Microphone_Center_Location(i,1),Microphone_Center_Location(i,2),'g.');
% hold on
%       end
%       return
	 
	 
	 
        %����ʸ��Mic_vector
        Mic_vector=Microphone_1_Location-Microphone_2_Location;
        %%%��֪����ʸ��Direct_vector=[a,b]������λ��(x0,y0)Microphone_Center_Location��
        %%%���㴹ֱƽ����a(x-x0)+b(y-y0)=0  
        a=Mic_vector(1:end,1);
        b=Mic_vector(1:end,2);
        x0=Microphone_Center_Location(1:end,1);
        y0=Microphone_Center_Location(1:end,2);
             
  
		 %�������˵����ʵ��λ�ã�������Ϣ����˵����λ����ʵ�ʽڵ�λ�ü���
		  measure_data=zeros(Node_number,1);  
       real_speaker_location=(Size_Grid*abs((rand(1,2)))); 
        speaker_x=real_speaker_location(1,1);
        speaker_y=real_speaker_location(1,2);
        tmp=a.*(speaker_x-x0)+b.*(speaker_y-y0);

        for i=1:Node_number
            if tmp(i)>0
                measure_data(i)=1;
            else
                measure_data(i)=0;
            end
        end
		
		%%%%%%%�и����%%%
        measure_data_probability=ones(Node_number,1);        
           for i=1:Node_number
          measure_data_probability(i)=measure_alpha;
           end
		   
         %%%%%%%%%%%%%%%%%%%����ڵ��λ����ָ�����, ׼����������
       %  Microphone_Cita_with_error=Microphone_Cita+angle_error_range_abs*2*(-0.5+rand(size(Microphone_Cita)));     
       %  Microphone_Center_Location_with_error=Microphone_Center_Location+location_error_range_abs*2*(-0.5+rand(size(Microphone_Center_Location)));
		  %%��������location_error_range_abs��λ�����
            Microphone_Cita_with_error=Microphone_Cita+angle_error_range_abs*sign(-0.5+rand(size(Microphone_Cita)));   
       Microphone_Center_Location_with_error=Microphone_Center_Location+location_error_range_abs*sign(-0.5+rand(size(Microphone_Center_Location))); 
 
% 		   		 %%%%%%%%%%%���� table_binary, ʵ�ʲ��ԣ������������� %%%%%%%%%%% 
 		 table_binary=zeros(Room_Width*scale*Room_Width*scale,Node_number+2);		  		 
  table_binary=creat_table(Microphone_Center_Location_with_error,Microphone_Cita_with_error,Microphone_Distance,Room_Width,Room_Length,scale,Node_number);
%  

		
		%%%������ɴ���ڵ�   ��Ϊ����SNR���ɴ���ڵ�
		
		SNR_Node_number=10*rand(1,Node_number);  		
		err_node=Generating_Error_Node(Node_number,Node_Error_NUM_Percent,SNR_Node_number);
		

		 measure_data_with_error=measure_data;	
         Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_number);
		   for i=1:Node_Error_NUM
            if measure_data_with_error(err_node(1,i))==0
                measure_data_with_error(err_node(1,i))=1;
            else
                measure_data_with_error(err_node(1,i))=0;
            end
        end
		
		%
        % measure_data
        % err_node
		% measure_data_with_error  
        % pause;
        
        %%����������λ������ ͳ�ƶ�λ���
        %%����������λ������ ͳ�ƶ�λ���
        estimated_location=Hamming_Distance_Method(measure_data_with_error',table_binary,KNN);        
		rmse_Hamming_tmp(count) = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %
  
          estimated_location=Advanced_Hamming_Distance_Method(measure_data_with_error',table_binary);        
		rmse_Advanced_Hamming_tmp(count) = sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  %
  
       estimated_location=SNR_Weight_Hamming_Distance_Method(measure_data_with_error',table_binary,SNR_Node_number);
		rmse_SNR_Weight_Hamming_tmp(count)= sqrt( sum((real_speaker_location(:)-estimated_location(:)).^2) );  % 
      
  
 
        estimated_location_2 = GM_Probility_Cutting(Node_number,measure_data_with_error,measure_data_probability,Microphone_Center_Location_with_error,Microphone_Distance,Microphone_Cita_with_error,Size_Grid,scale);        
		rmse_Probility_Cutting_tmp(count) = sqrt( sum((real_speaker_location(:)-estimated_location_2(:)).^2) );  % 
		
        count=count+1;
    
    
    end  
    rmse_Hamming_final_Anchors(runs,:)=rmse_Hamming_tmp;
	 rmse_Advanced_Hamming_final_Anchors(runs,:)=rmse_Advanced_Hamming_tmp;
   rmse_SNR_Weight_Hamming_final_Anchors(runs,:)= rmse_SNR_Weight_Hamming_tmp;
   % rmse_Probility_Cutting_final_Anchors(runs,:)=rmse_Probility_Cutting_tmp;  
	
     
end  






	disp(['Saving and Drawing................. ']);

save Hamming_test.mat  RUNS Size_Grid  anchors   real_statics_run rmse_Hamming_final_Anchors;
save Advanced_Hamming_test.mat  RUNS Size_Grid  anchors   real_statics_run rmse_Advanced_Hamming_final_Anchors;
save SNR_Weight_Hammingg_test.mat  RUNS Size_Grid  anchors  real_statics_run     rmse_SNR_Weight_Hamming_final_Anchors;




clear all;
load Hamming_test.mat
load Advanced_Hamming_test.mat
load SNR_Weight_Hammingg_test.mat


%%������С��������ȡǰ90%
[A,B]=sort(rmse_Hamming_final_Anchors);
rmse_Hamming_MC = mean(A(1:real_statics_run,:));

[A,B]=sort(rmse_Advanced_Hamming_final_Anchors);
rmse_Advanced_Hamming_MC = mean(A(1:real_statics_run,:));

[A,B]=sort(rmse_SNR_Weight_Hamming_final_Anchors);
 rmse_SNR_Weight_Hamming_MC = mean(A(1:real_statics_run,:));


figure('Position',[1 1 1200 900])

 plot(anchors, rmse_Hamming_MC, 'rs-', 'LineWidth', 2, 'MarkerFaceColor', 'r');
 hold on;
  plot(anchors, rmse_Advanced_Hamming_MC, 'g^-', 'LineWidth', 2, 'MarkerFaceColor', 'g');
 plot(anchors, rmse_SNR_Weight_Hamming_MC, 'bd-', 'LineWidth', 2, 'MarkerFaceColor', 'b');%
hold off
legend('\fontsize{12}\bf Basic Hamming','\fontsize{12}\bf Advanced Hamming','\fontsize{12}\bf SNR Weight Hamming');

xlabel('\fontsize{12}\bf Node Angle Error');
ylabel('\fontsize{12}\bf Localization Error(in units)');
title('\fontsize{12}\bf  Localization Error vs. Node Angle Error');









