
module One_Shot
(
	// Input Ports
	input clk,
	input reset,
	input Start,

	// Output Ports
	output Shot
);


enum logic [1:0] {Waiting_Shot, Shot_State, Waiting_Not_Shot} state;
logic Shot_reg;
wire Not_Start;



assign Not_Start = Start;
/*------------------------------------------------------------------------------------------*/
/*Asignacion de estado*/

always_ff@(posedge clk or negedge reset)
begin
	if(reset == 1'b0) begin 
		state<=Waiting_Shot;
	end
	else begin
		case(state)
		
		Waiting_Shot:
			if(Not_Start == 1'b1)
				state <= Waiting_Not_Shot;
				
		Shot_State:
			if(Not_Start == 1'b1)
				state <= Waiting_Not_Shot;
		
		Waiting_Not_Shot:
			if (Not_Start == 1'b0)
				state <= Shot_State;	
				
		default:
				state <= Waiting_Shot;

		endcase
		
	end
end//end always
/*------------------------------------------------------------------------------------------*/
/*Salida de control, proceso combintorio*/
always_comb begin
	case(state)
		Waiting_Shot: 
				Shot_reg=1'b0;

		Shot_State: 
				Shot_reg=1'b1;

		Waiting_Not_Shot: 
				Shot_reg=1'b0;
	default: 		
				Shot_reg=1'b0;
				
	endcase
end

assign Shot = Shot_reg;

endmodule
