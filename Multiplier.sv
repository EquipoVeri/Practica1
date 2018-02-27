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
wire [15:0] multiplier_wire;
wire [15:0] multiplicand_wire;
wire [15:0] shiftRight_wire;
wire [15:0] shiftLeft_wire;
wire [15:0] zeroMultiplicand_wire;
wire [15:0] adder_wire;
wire [15:0] product_log;
wire [15:0] product_ready;
wire [15:0] sleft_log;
wire [15:0] sright_log;

Control control
(
	.clk(clk),
	.reset(reset),
	.Start(start),
	.enable(flag32_bit),
	.Sync_Reset(flag0_bit),
	.Shot(enable_bit),
	.flag0(flag0_bit),
	.flag32(flag32_bit)
);
/*
One_Shot shot
(
	.clk(clk),
	.reset(reset),
	.Start(start),
	.Shot(enable_bit)
);*/

Multiplexer2to1_init mux_multiplicand
(
	.Selector(flag0_bit),
	.MUX_Data0(sleft_log),
	.MUX_Data1(multiplicand),
	.MUX_Output(multiplicand_wire)
);

Multiplexer2to1_init mux_multiplier
(
	.Selector(flag0_bit),
	.MUX_Data0(sright_log),
	.MUX_Data1(multiplier),
	.MUX_Output(multiplier_wire)
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


Multiplexer2to1 mux_zeromultiplicand
(
	.Selector(shiftRight_wire[0]),
	.MUX_Data0(16'b0),
	.MUX_Data1(shiftLeft_wire),
	.MUX_Output(zeroMultiplicand_wire)
);

AdderRegister adder
(
	.Data_Add(product_log),
	.Data_Input(zeroMultiplicand_wire),
	.Data_Output(adder_wire)
);

//assign adder_wire = product_log + zeroMultiplicand_wire;

assign sleft_log = shiftLeft_wire << 1;
assign sright_log = shiftRight_wire >> 1;

/*
CounterWithFunction counter
(
	.clk(clk),
	.reset(reset),
	.enable(enable_bit),
	.flag0(flag0_bit),
	.flag32(flag32_bit) 
);*/

Register_With_Sync_Reset regsync
(
	.clk(clk),
	.reset(reset),
	.enable(enable_bit),
	.Sync_Reset(flag0_bit),
	.Data_Input(adder_wire),
	.Data_Output(product_log)
);

Register_With_Sync_Reset registerReady
(
	.clk(clk),
	.reset(reset),
	.enable(flag32_bit),
	.Sync_Reset(start),
	.Data_Input(product_log),
	.Data_Output(product_ready)
);

assign product = product_ready;
assign ready = flag32_bit;

endmodule


