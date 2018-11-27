// D-flip flop implementation


//Normal D-flip flop
module dff(D, clk, Q);

input D, clk;
output Q;

reg Q;

always @(posedge clk) begin
	Q <= #1 D;
end

endmodule

//Reset D-flip flop
module dff_r(D, clk, reset_n, Q);

input D, clk, reset_n;
output Q;

reg Q;

always @(posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0) begin
		Q <= #1 1'b0;
	end
	else begin
		Q <= #1 D;
	end

end

endmodule

//Clock enble
module dff_r_ce(D, clk, CE, reset_n, Q);

input D, clk, CE, reset_n;
output Q;

reg Q;

always @(posedge clk or negedge reset_n) begin
	if (reset_n == 1'b0) begin
		Q <= #1 1'b0;
	end
	else begin
		if (CE == 1'b0)
			Q <= #1 Q;
		else 
			Q <= #1 D;
	end
	

end

endmodule