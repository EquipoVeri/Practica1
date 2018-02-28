/******************************************************************* 
* Name:
*	Sign.sv
* Description:
* 	This module realize a shift Left of the input
* Inputs:
*	Data_Input
* Outputs:
* 	Data_Output
* Versión:  
*	1.0
* Author: 
*	Felipe Garcia & Diego Reyna
* Fecha: 
*	25/02/2018 
*********************************************************************/
module ShiftLeft
#(
	parameter Word_Length = 8
)

(
	// Input Ports
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output [Word_Length-1:0] Data_Output
);

assign Data_Output = Data_Input << 1;

endmodule