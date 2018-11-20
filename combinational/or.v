/*This is an example for explicit or circuit implementation */

module eight_gate(man, L);

input [7:0] man;
output L;
wire L;
wire [3:0] vote_count;


parameter YES_NUM = 4'd4;
assign vote_count = man[0]+man[1]+man[2]+man[3]+
					man[4]+man[5]+man[6]+man[7];
assign L = vote_count[3:0] >= YES_NUM ? 1'b1 : 1'b0;

endmodule


//------------------------------
module three_gate(A, B, C, L);

input A, B, C;
output L;
wire L;

eight_gate #(.YES_NUM (2)) u1(
	.man ({5'd0, C, B, A}),
	.L (L)
	);

endmodule