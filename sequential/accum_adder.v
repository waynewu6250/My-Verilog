/* This is an example for implementing an accumulator-adder, 
which is a common structure in Algorithm Logic Unit (ALU).*/

//Pipeline
module ALT_MULTADD(iCLK, iRST_N, iA0, iB0, iA1, iB1, MultAdd);

input iCLK, iRST_N;
input [7:0] iA0, iB0, iA1, iB1;
output [16:0] MultAdd;
reg [7:0] a0, a1, b0, b1;
reg [16:0] m0, m1;
reg [16:0] result;

assign MultAdd = result;

always @(posedge iCLK or negedge iRST_N) begin
	
	if (iRST_N == 1'b0) begin
		a0 <= #1 0;
		b0 <= #1 0;
		a1 <= #1 0;
		b1 <= #1 0;
	end
	else begin
		a0 <= #1 iA0;
		b0 <= #1 iB0;
		a1 <= #1 iA1;
		b1 <= #1 iB1;
		m0 <= #1 a0*b0;
		m1 <= #1 a1*b1;
		result <= m0+m1;
	end

end

endmodule
