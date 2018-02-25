module Multiplier
(
	// Input Ports
	input clk,
	input reset,
	input start,
	input [7:0] multiplier,
	input [7:0] multiplicand,

	// Output Ports
	output ready,
	output [15:0] product
);

bit enable_bit;
bit flag0_bit;
bit flag32_bit;
wire [7:0] multiplier_wire;
wire [7:0] multiplicand_wire;
wire [7:0] shiftRight_wire;
wire [7:0] shiftLeft_wire;
wire [7:0] zeroMultiplicand_wire;
wire [15:0] adder_wire;
wire [15:0] product_log;
wire [15:0] product_ready;


One_Shot shot
(
	.clk(clk),
	.reset(reset),
	.Start(start),
	.Shot(enable_bit)
);

Multiplexer2to1 mux_multiplicand
(
	.Selector(flag0_bit),
	.MUX_Data0(shiftLeft_wire),
	.MUX_Data1(multiplicand),
	.MUX_Output(multiplicand_wire)
);

Multiplexer2to1 mux_multiplier
(
	.Selector(flag0_bit),
	.MUX_Data0(shiftRight_wire),
	.MUX_Data1(multiplier),
	.MUX_Output(multiplier_wire)
);

Multiplexer2to1 mux_zeromultiplicand
(
	.Selector(shiftRight_wire[0]),
	.MUX_Data0(8'b0),
	.MUX_Data1(shiftLeft_wire),
	.MUX_Output(zeroMultiplicand_wire)
);


ShiftLeftRegister shiftleft
(
	.clk(clk),
	.reset(reset),
	.Data_Input(multiplicand_wire), 
	.Data_Output(shiftLeft_wire)
);

ShiftRigthRegister shiftright
(
	.clk(clk),
	.reset(reset),
	.Data_Input(multiplier_wire), 
	.Data_Output(shiftRight_wire)
);

AdderRegister adder
(
	.clk(clk),
	.reset(reset),
	.Data_Add(product_log),
	.Data_Input(zeroMultiplicand_wire),
	.Data_Output(adder_wire)
);

//assign adder_wire = product_log + zeroMultiplicand_wire;

CounterWithFunction counter
(
	.clk(clk),
	.reset(reset),
	.enable(enable_bit),
	.flag0(flag0_bit),
	.flag32(flag32_bit) 
);

Register_With_Sync_Reset regsync
(
	.clk(clk),
	.reset(reset),
	.enable(enable_bit),
	.Sync_Reset(start),
	.Data_Input(adder_wire),
	.Data_Output(product_log)
);

Register registerReady
(
	.clk(clk),
	.reset(reset),
	.enable(flag32_bit),
	.Data_Input(product_log),
	.Data_Output(product_ready)
);

assign product = product_ready;
assign ready = flag32_bit;

endmodule


