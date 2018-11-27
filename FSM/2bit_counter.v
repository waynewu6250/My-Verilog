// Example for turning a 2-bit counter into FSM

module counter(reset_n, enable, clk, out);

input reset_n, enable, clk;
output [1:0] out;

reg [1:0] out;

always @(posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0)
		out <= #1 2'b0;
	else begin
		if (enable)
			out <= #1 (out == 2'b1) ? 2'b0 : out+1'b1;
		else begin
			out <= #1 out;
		end
	end
end

endmodule


// We will have current_state, next_state
// and every possible state we have
module counter_fsm(reset_n, enable, clk, out);

input reset_n, enable, clk;
output [1:0] out;
reg [1:0] current_state, next_state;
wire [1:0] out;

parameter s0 = 2'b00,
		  s1 = 2'b01,
		  s2 = 2'b10,
		  s3 = 2'b11;

always @(posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0)
		current_state <= #1 s0;
	else begin
		current_state <= #1 next_state;
	end
end

always @(posedge clk or current_state) begin
	case (current_state)
		s0: next_state <= #1 (enable) ? s1: s0;
		s1: next_state <= #1 (enable) ? s2: s1;
		s2: next_state <= #1 (enable) ? s3: s2;
		s3: next_state <= #1 (enable) ? s0: s3;
		default: next_state = s0;
	endcase

end

endmodule





