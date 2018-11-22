/* Three versions of multipliers*/

module mul1(in1, in2, out1, out2, out3);

input [3:0] in1, in2;
output [7:0] out1, out2, out3;
wire [7:0] out1, out2, out3;
wire [3:0] t0,t1,t2,t3;
wire [3:0] v0,v1,v2,v3;

//Method 1: multiply directly
assign out1 = {4'd0, in1} * {4'd0, in2};



//Method 2: Depending on every bit on in1, output whether in2 or 0, use ?= to implement
assign t0 = (in1[0]==1) ? in2[3:0] : 4'd0;
assign t1 = (in1[1]==1) ? in2[3:0] : 4'd0;
assign t2 = (in1[2]==1) ? in2[3:0] : 4'd0;
assign t3 = (in1[3]==1) ? in2[3:0] : 4'd0;

assign out2 = t0 + (t1<<1) + (t2<<2) + (t3<<3);



//Method 3: Depending on every bit on in1,, output whether in2 or 0, use bit-wise AND to implement
assign t0 = in2[3:0] & {in1[0], in1[0], in1[0], in1[0]};
assign t1 = in2[3:0] & {in1[1], in1[1], in1[1], in1[1]};
assign t2 = in2[3:0] & {in1[2], in1[2], in1[2], in1[2]};
assign t3 = in2[3:0] & {in1[3], in1[3], in1[3], in1[3]};

assign out3 = {4'd0,t0[3:0]} +
			  {3'd0,t0[3:0],1'd0} +
			  {2'd0,t0[3:0],2'd0} + 
			  {1'd0,t0[3:0],3'd0};  


endmodule






