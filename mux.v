module mux1(A, B, sel, L);

input A, B, sel;
output L;

wire L;
assign L = (sel == 1'b1) ? A : B;

endmodule




module mux2(A, B, sel, L);

input A, B, sel;
output L;

reg L;
always @(A or B or sel) begin
	L = (sel == 1'b1) ? A : B;
end

endmodule
