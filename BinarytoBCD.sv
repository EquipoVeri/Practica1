module BinarytoBCD
(
	// Input Ports
	input [15:0] binary_input,
	output reg [3:0] units,
	output reg [3:0] hundreds,
	output reg [3:0] tens,
	output reg [3:0] onethousand,
	output reg [3:0] tenthousands
);

//logic [3:0] units_log;
//logic [3:0] tens_log;
//logic  hundreds_log;
logic [15:0] binary_log;
logic [4:0] i_log;

always_comb
begin: ThisIsaDecoder

binary_log = binary_input;

units = 4'd0;
tens = 4'd0;
hundreds = 4'd0;
onethousand = 4'd0;
tenthousands = 4'd0;

for(i_log=16 ;i_log > 0;i_log=i_log-1)
begin
	if(units >= 5)
		units = units + 3;
	if(tens >= 5)
		tens = tens + 3;
	if(hundreds >= 5)
		hundreds = hundreds + 3;
	if(onethousand >= 5)
		onethousand = onethousand + 3;
	if(tenthousands >= 5)
		tenthousands = tenthousands + 3;	
	
	tenthousands = tenthousands << 1;	
	tenthousands[0] = onethousand[3];	
	onethousand = onethousand << 1;
	onethousand[0] = hundreds[3];
	hundreds = hundreds << 1;
	hundreds[0] = tens[3];	
	tens = tens << 1;
	tens[0] = units[3];
	units = units << 1;
	units[0] = binary_log[i_log-1];

end

end// end always


endmodule
