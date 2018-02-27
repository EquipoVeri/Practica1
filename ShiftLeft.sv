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