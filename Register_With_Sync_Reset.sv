/******************************************************************* 
* Name:
*	Register_With_Sync_Reset.sv
* Description:
* 	This module is a register with a sync reset
* Inputs:
*	clk, reset, Data_Input, enable, Sync_Reset, sign,
* Outputs:
* 	signOut, Data_Output
* Versión:  
*	1.0
* Author: 
*	Felipe Garcia & Diego Reyna
* Fecha: 
*	21/02/2018 
*********************************************************************/
module Register_With_Sync_Reset
#(
	parameter Word_Length = 16
)

(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input Sync_Reset,
	input sign,
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output signOut,
	output [Word_Length-1:0] Data_Output
);

bit sign_bit;
logic [Word_Length-1:0] Data_logic;

always_ff@(posedge clk or negedge reset) begin: ThisIsARegister
	if(reset == 1'b0) 
		Data_logic <= {Word_Length{1'b0}};
	else
		if(enable == 1'b1) begin: Enable
			if(Sync_Reset == 1'b1)
				Data_logic <= {Word_Length{1'b0}};
			else 	begin: SynchronousReset	
				Data_logic <= Data_Input;	
				sign_bit <= sign;
			end: SynchronousReset
		end: Enable
end: ThisIsARegister

assign Data_Output = Data_logic;
assign signOut = sign_bit;


endmodule
