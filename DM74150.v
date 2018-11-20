/*Design a IC chip DM74150 fabricated by Fairchild Semiconductor Corporation \n
  Multiplexer Design*/

/*Basic Opration:
  When strobe is high, keep all the input low.
  When strobe is low, use select A, B, C, D to select data.
 */

module DM74150(F, S, A, B, C, D, L);

input [15:0] F;
input S;
input A, B, C, D;
output L;
reg L;

assign control = {D, C, B, A};
always @(S or A or B or C or D) begin
	if (S == 1'b1) L = 1'b0;
	else begin
		case (control)
			(4'h0) : L = ~F[0];
			(4'h1) : L = ~F[1];
			(4'h2) : L = ~F[2];
			(4'h3) : L = ~F[3];
			(4'h4) : L = ~F[4];
			(4'h5) : L = ~F[5];
			(4'h6) : L = ~F[6];
			(4'h7) : L = ~F[7];
			(4'h8) : L = ~F[8];
			(4'h9) : L = ~F[9];
			(4'hA) : L = ~F[10];
			(4'hB) : L = ~F[11];
			(4'hC) : L = ~F[12];
			(4'hD) : L = ~F[13];
			(4'hE) : L = ~F[14];
			(4'hF) : L = ~F[15];
			default : L = F[16];
		endcase
	end
end

endmodule