module TwoComplement8bits
(
	// Input Ports
	input [7:0] signed_input,
		
	output [7:0] unsigned_output,
	output sign
);

logic sign_log;
logic [7:0] input_log;


always_comb
begin
if(signed_input[7] == 1'b1)
begin
	sign_log = 1'b1 ;
	input_log = ~signed_input + 1;
end
else begin
	sign_log = 1'b0;
	input_log = signed_input;
end
end

assign sign = sign_log;
assign unsigned_output = input_log;

endmodule

