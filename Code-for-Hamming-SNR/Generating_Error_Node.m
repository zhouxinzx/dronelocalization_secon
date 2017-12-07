function Error_Node = Generating_Error_Node(Node_number,Node_Error_NUM_Percent,SNR_Node_number)

%%SNR--0-10
		
 [temp,index]=sort(SNR_Node_number);	
 
		 Node_Error_NUM=floor(Node_Error_NUM_Percent*Node_number);

         
		 Error_Node=index(1:Node_Error_NUM);

		 







