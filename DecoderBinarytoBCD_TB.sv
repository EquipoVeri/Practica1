
timeunit 1ps; //It specifies the time unit that all the delay will take in the simulation.
timeprecision 1ps;// It specifies the resolution in the simulation.

module DecoderBinarytoBCD_TB;


// Input Ports
logic [7:0] binary_input;

 // Output Ports
logic[3:0] units;
logic[3:0] tens;
logic[3:0] hundreds;
logic sign;

DecoderBinarytoBCD
DUT
(
	// Input Ports
	.binary_input(binary_input),
	
	// Output Ports
	.units(units),
	.tens(tens),
	.hundreds(hundreds),
	.sign(sign)

);	

/*********************************************************/
initial begin
	#8 binary_input = 121;
  end

endmodule
