module Register_With_Clock_Enable
#(
	parameter Word_Length = 8
)
(
	// Input Ports
	input clk,
	input reset,
	input enable,
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output logic [Word_Length-1:0] Data_Output
);

always_ff@(posedge clk or negedge reset) begin:ThisIsARegister
	if(reset == 1'b0) 
		Data_Output <= {Word_Length{1'b0}};
	else 
		if (enable == 1'b1)
			Data_Output <= Data_Input;
end:ThisIsARegister


endmodule