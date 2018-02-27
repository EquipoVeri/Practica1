module DecoderBinarytoBCD
#(
	parameter place_value = 7
)
(
	// Input Ports
	input [15:0] binary_input,
	output [6:0] units,
	output [6:0] hundreds,
	output [6:0] tens,
	output [6:0] onethousand,
	output [6:0] tenthousands,
	output sign
	
);



logic [15:0] unsigned_log;

logic [3:0] tenthousandsBCD_log;
logic [6:0] tenthousands_log;
logic [3:0] onethousandBCD_log;
logic [6:0] onethousand_log;
logic [3:0] hundredsBCD_log;
logic [6:0] hundreds_log;
logic [3:0] tensBCD_log;
logic [6:0] tens_log;
logic [3:0] unitsBCD_log;
logic [6:0] units_log;
logic sign_log;

TwoComplement c2 (
	.signed_input(binary_input), 
	.unsigned_output(unsigned_log), 
	.sign(sign_log)
);

BinarytoBCD binaryBCD (
	.binary_input(unsigned_log), 
	.units(unitsBCD_log), 
	.hundreds(hundredsBCD_log),
	.tens(tensBCD_log), 
	.onethousand(onethousandBCD_log), 
	.tenthousands(tenthousandsBCD_log)
);

	
BCDto7Segments segments7units (.in(unitsBCD_log), .segments(units_log));

BCDto7Segments segments7tens (.in(tensBCD_log), .segments(tens_log));

BCDto7Segments segments7hundreds (.in(hundredsBCD_log), .segments(hundreds_log));

BCDto7Segments segments7onethousand (.in(onethousandBCD_log), .segments(onethousand_log));

BCDto7Segments segments7tenthousands (.in(tenthousandsBCD_log), .segments(tenthousands_log));


assign units = units_log;
assign tens = tens_log;
assign hundreds = hundreds_log;
assign onethousand = onethousand_log;
assign tenthousands = tenthousands_log;
assign sign = sign_log;
	 

endmodule



