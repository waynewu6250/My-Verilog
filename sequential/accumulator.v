/* Implement an accumulator with positive edge triggered*/

module accumulator(clk, clr, data, accum, overflow);

input clk, clr;
input [7:0] data;
output [7:0] accum;
output overflow;

reg [7:0] accum;
reg overflow;

always @(posedge clk) begin
	if (clr == 1'b1) begin
		accum <= #1 8'h0;
		overflow <= #1 1'b0;
	end
	else begin
		{overflow, accum} <= #1 accum + data;
	end

	
end

endmodule