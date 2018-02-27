/******************************************************************
* Description
*	This is the verifaction envioroment for a sequential multiplier
* Version:
*	1.0
* Author:
*	Dr. José Luis Pizano Escalante
* email:
*	luispizano@iteso.mx
* Date:
*	01/03/2014
******************************************************************/
timeunit 10ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module SequentialMultiplier_TB;

parameter WORD_LENGTH = 16;

bit clk = 0;
bit reset; 

bit Start = 0;
logic [WORD_LENGTH-1:0] Multiplicand = 0;
logic [WORD_LENGTH-1:0] Multiplier = 0;
	// Output
wire ready;
wire [2*WORD_LENGTH-1:0] Product;

SequentialMultiplier
#(
	.WORD_LENGTH(WORD_LENGTH)
)
DUV
(
	// Inputs
	.clk(clk),
	.reset(reset),
	.Start(Start),
	.Multiplicand(Multiplicand),
	.Multiplier(Multiplier),
	// Output
	.ready(ready),
	.Product(Product)
);


/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk = !clk;
  end
/*********************************************************/
initial begin // reset generator
	#0 reset = 1;
end

/*********************************************************/
initial begin // reset generator
	#8 Start = 1;
	#5 Start = 0;
	#80 Start = 1;
	#5 Start = 0;
end

initial begin 
	#4 Multiplicand = 8;
	#50 Multiplicand = 30;
	
end

initial begin 
	#4 Multiplier = 12;
	#50 Multiplier = 4;
end


/*********************************************************/
endmodule