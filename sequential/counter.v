// Synchronous Counter Implementation

module counter(clk, reset_n, CE, out);

input clk, reset_n, CE;
output [3:0] out;

reg [3:0] out;

always @(posedge clk or negedge reset_n) begin
	
	if (reset_n == 1'b0) begin
		out <= #1 1'b0;
	end
	else begin
		
		if (CE)
			out <= #1 out + 4'd1;
		else
			out <= #1 out;
	end
end

endmodule