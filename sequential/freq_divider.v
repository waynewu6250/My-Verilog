/* Frequency Divider Implementation:
Used for Phase Loop Lock (PLL) Circuit to provide different frequency output*/

// divide 2
module div2(clk, clk2, reset_n);

input clk, reset_n;
output clk2;
reg clk2;

always @(posedge clk or negedge reset_n) begin
	
	if (reset_n == 1'b0)
		clk2 <= #1 1'b0;
	else begin
		clk2 <= ~clk2;
	end

end

endmodule

//////////////////////////////////////////////////////////
// divide 2,4,8,16
module div2_4_8_16(clk, clk2, clk4, clk8, clk16, reset_n);

input clk, reset_n;
output clk2, clk4, clk8, clk16;
// counter
reg [3:0] counter;
wire clk2, clk4, clk8, clk16;

always @(posedge clk) begin
	if (reset_n == 1'b0)
		counter <= #1 4'h0;
	else begin
		counter <= #1 counter + 4'd1;
	end
end

assign clk2 = counter[0];
assign clk4 = counter[1];
assign clk8 = counter[2];
assign clk16 = counter[3];


endmodule


////////////////////////////////////////////////////////////