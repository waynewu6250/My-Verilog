/*Simple 32-bit Divider Implementation

Steps:
1. Make dividend A to temp_a {32'h0000_0000,a[31:0]}
   Make divisor B to tempb {b[31:0],32'h0000)0000}
2. Run 32 times:
   (1) Shift one-bit left A, and compare with B
   (2) If A > B, do tempa-tempb+1
       Else, do A=A
3. High 32-bit is remainder, Low 32-bit is quotient
*/

module Divider(a, b, q, r);

input [31:0] a,b;
output [31:0] q,r;
reg [31:0] q,r;
reg [31:0] tempa, tempb;
reg [63:0] temp_a, temp_b;


integer i;
always @(a or b) begin
	tempa = a;
	tempb = b;
end


always @(temp_a or temp_b) begin
	temp_a = {31'h0000_0000, tempa};
	temp_b = {tempb, 31'h0000_0000};
	for (i = 0; i<32; i = i+1) begin

		temp_a = {temp_a[62:0],1'b0};
		if (temp_a[63:32] >= tempb[31:0]) begin
			temp_a = temp_a - temp_b +1;
		end
		else begin
			temp_a = temp_a;
		end
	
	end

	q = temp_a[31:0];
	r = temp_a[63:32];
end

endmodule

