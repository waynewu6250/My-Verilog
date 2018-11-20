module encoder(A, Y);

parameter SIZE = 3;
input [2**SIZE-1:0] A;
output [SIZE-1:0] Y;
reg [SIZE-1:0] Y;

integer i;
always @(i or A) begin
	Y = 'bx;
	for (i=2**SIZE-1; i>=0; i-=1)
		if (A[i] == 1) Y = i;
end

endmodule