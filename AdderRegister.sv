/******************************************************************* 
* Name:
*	AdderRegister.sv
* Description:
* 	This module realize an add of two inputs
* Inputs:
*	Data_Add, Data_Input
* Outputs:
* 	Data_Output
* Versión:  
*	1.0
* Author: 
*	Felipe Garcia & Diego Reyna
* Fecha: 
*	21/02/2018 
*********************************************************************/
module AdderRegister
#(
	parameter Word_Length = 16
)

(
	// Input Ports
	input [Word_Length-1:0] Data_Add,
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output [Word_Length-1:0] Data_Output
);

logic  [Word_Length-1:0] Data_logic;

always_comb begin
	if(Data_Input != Data_Add)
		Data_logic = Data_Input + Data_Add;
	else
		Data_logic = Data_Add;
end

assign Data_Output = Data_logic;

endmodule