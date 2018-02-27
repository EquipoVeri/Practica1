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
	input [Word_Length-1:0] Data_Input,

	// Output Ports
	output [Word_Length-1:0] Data_Output
);

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
			end: SynchronousReset
		end: Enable
end: ThisIsARegister

assign Data_Output = Data_logic;

endmodule
