/*Design a IC chip DM74153 fabricated by National Semiconductor Corporation \n
  Multiplexer Design*/

/*Basic Opration:
  When strobe is high, keep all the input low.
  When strobe is low, use select A and B to select data.
 */

module DM74153(G, A, B, C0, C1, C2, C3, L);

input C0, C1, C2, C3;
input G;
input A, B;
output L;
reg L;

always @(C0 or C1 or C2 or C3 or G or A or B) begin
	if (G == 1'b1) L = 1'b0;
	else begin
		if (B == 1'b0) L = (A == 1'b0)? C0 : C1;
		if (B == 1'b1) L = (A == 1'b0)? C2 : C3;
	end
end

endmodule