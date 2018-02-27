module Control
#(
	// Parameter Declarations
	parameter ZERO = 0,
	parameter MAXIMUM_VALUE = 36,
	parameter NBITS_FOR_COUNTER = CeilLog2(MAXIMUM_VALUE)
)

(
	// Input Ports
	input clk,
	input reset,
	input Start,
	input enable,
	input Sync_Reset,

	
	// Output Ports
	output Shot,
	output flag0,
	output flag32 
);


enum logic [1:0] {Waiting_Shot, Shot_State, Waiting_Not_Shot} state;
logic Shot_reg;
wire Not_Start;
bit MaxValue_Bit;
bit Zero_Bit;

logic [NBITS_FOR_COUNTER-1 : 0] Count_logic;


assign Not_Start = Start;
/*------------------------------------------------------------------------------------------*/
/*Asignacion de estado*/
/*
always_ff@(posedge clk or negedge reset)
begin
	if(reset == 1'b0)
	 if(Sync_Reset == 1'b1)
		state <= Waiting_Shot;
	 else
		state <= Waiting_Not_Shot;
	else
		if(enable  == 1'b1) begin: Enable
			if(Sync_Reset == 1'b1)
				state <= Waiting_Shot;
			else 	begin: SynchronousReset	
				state <= Waiting_Not_Shot;
			end: SynchronousReset
		end: Enable
	
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
*/


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

/*------------------------------------------------------------------------------------------*/

always_ff@(posedge clk or negedge reset) begin
	if (reset == 1'b0)
		Count_logic <= {NBITS_FOR_COUNTER{1'b0}};
	else begin
			if(Shot_reg == 1'b1)
				if(Count_logic == MAXIMUM_VALUE - 1)
					Count_logic <= 0;
				else
					Count_logic <= Count_logic + 1'b1;
	end
end

//--------------------------------------------------------------------------------------------

always_comb begin
	if(Count_logic == ZERO)
		Zero_Bit = 1;
	else
		Zero_Bit = 0;
	if(Count_logic == MAXIMUM_VALUE-1)
		MaxValue_Bit = 1; 
	else
		MaxValue_Bit = 0;
end
		
//---------------------------------------------------------------------------------------------
assign flag32 = MaxValue_Bit;
assign flag0 = Zero_Bit;
//----------------------------------------------------------------------------------------------

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
   
 /*Log Function*/
     function integer CeilLog2;
       input integer data;
       integer i,result;
       begin
          for(i=0; 2**i < data; i=i+1)
             result = i + 1;
          CeilLog2 = result;
       end
    endfunction

/*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
 /*--------------------------------------------------------------------*/
endmodule
