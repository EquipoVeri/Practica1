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

module Multiplier_TB;

bit clk = 0;
bit reset; 

bit start = 0;
logic [7:0] multiplicand = 0;
logic [7:0] multiplier = 0;
	// Output
wire ready;
wire [15:0] product;

Multiplier

DUV
(
	// Inputs
	.clk(clk),
	.reset(reset),
	.start(start),
	.multiplicand(multiplicand),
	.multiplier(multiplier),
	// Output
	.ready(ready),
	.product(product)
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
	#15 start = 1;
	#18 start = 0;
end

initial begin 
	#0 multiplicand = 127;
	#0 multiplier = 127;
	
end

/*********************************************************/
endmodule