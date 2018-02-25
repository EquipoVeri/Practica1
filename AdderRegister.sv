 module AdderRegister
#(
	parameter Word_Length = 8
)

(
	// Input Ports
	input clk,
	input reset,
	input [15:0] Data_Add,
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output [15:0] Data_Output
);

logic  [15:0] Data_logic;

always_ff@(posedge clk or negedge reset) begin: ThisIsARegister
	if(reset == 1'b0) 
		Data_logic <= 0;
	else 
		Data_logic <= Data_Input + Data_Add;
end: ThisIsARegister

assign Data_Output = Data_logic;

endmodule