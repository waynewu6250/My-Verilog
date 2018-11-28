// Example for a mealy machine with 3 always blocks

module mealy(clk, reset_n, in1, in2, out);

input clk, reset_n, in1, in2;
output out;
reg [1:0] current_state, next_state;
reg out;

parameter IDLE = 2'b00,
		  S0 = 2'b01,
		  S1 = 2'b10;

//first always: define current state
always @(posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0)
		current_state <= #1 1'b0;
	else begin
		current_state <= #1 next_state;
	end
end

//Second always: define next_state
always @(current_state or in1) begin
	case (current_state)
		(IDLE) : next_state = (in1==1'b1) ? S0 : IDLE;
		(S0) : next_state = (in1==1'b1) ? S1 : S0;
		(S1) : next_state = (in1==1'b1) ? S1 : IDLE;
		default : next_state = IDLE;
	endcase
end

//Third always: define ouptut
always @(next_state or in1 or in2) begin
	case (next_state)
		(IDLE) : out = 1'b0;
		(S0) : out = in1 & in2;
		(S1) : out = ~in2;
		default : out = 1'b0;
	endcase
end

endmodule