module P1
(
	input clk,
	input reset,
	input start,
	input [7:0] multiplier,
	input [7:0] multiplicand,
	output [6:0] units,
	output [6:0] hundreds,
	output [6:0] tens,
	output [6:0] onethousand,
	output [6:0] tenthousands,
	output sign,
	output ready
);

logic [15:0] product_logic;


Multiplier mult
(
	// Input Ports
	.clk(clk),
	.reset(reset),
	.start(start),
	.multiplier(multiplier),
	.multiplicand(multiplicand),

	// Output Ports
	.ready(ready),
	.product(product_logic),
	.sign(sign)
);

DecoderBinarytoBCD decoder
(
	// Input Ports
	.binary_input(product_logic),
	.units(units),
	.hundreds(hundreds),
	.tens(tens),
	.onethousand(onethousand),
	.tenthousands(tenthousands),
	.sign()
);



endmodule
