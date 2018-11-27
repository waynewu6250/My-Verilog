///////////////////////////////////////////////////////
/* Serial in Serial Out Shift Register Implementation*/
// serial in: no load input
// parallel in: add load input
// serial out: define reg
// parallel out: just out
///////////////////////////////////////////////////////

module SISO_Shift_Register(in, clock, clear, out);

input in, clock, clear;
output out;
reg [3:0] reg4;
wire out;

always @(posedge clock or negedge clear) begin
	if (clear)
		reg4 <= #1 4'b0;
	else begin
		reg4[0] <= #1 in;
		reg4[1] <= #1 reg4[0];
		reg4[2] <= #1 reg4[1];
		reg4[3] <= #1 reg4[2];
	end
end

assign out = reg4[3];

endmodule

/////////////////////////////////////////////////////////
/* Serial in Parallel Out Shift Register Implementation*/
/////////////////////////////////////////////////////////

module SIPO_Shift_Register(in, clock, clear, out);

input in, clock, clear;
output [3:0] out;
reg [3:0] out;

always @(posedge clock or negedge clear) begin
	if (clear)
		out <= #1 4'b0;
	else begin
		out[3:1] <= #1 out[2:0];
		out[0] <= #1 in;
	end
end

endmodule


/////////////////////////////////////////////////////////
/* Parallel in Serial Out Shift Register Implementation*/
/////////////////////////////////////////////////////////

module PISO_Shift_Register(in, load, clock, clear, out);

input [3:0] in;
input load, clock, clear;
output out;
reg [3:0] reg4;


always @(posedge clock or negedge clear) begin
	if (clear)
		reg4 <= #1 4'b0;
	else begin
		reg4[3:0] <= #1 load ? in[3:0] : {reg4[2:0], 1'b0};
	end
end

assign out = reg4[3];

endmodule

///////////////////////////////////////////////////////////
/* Parallel in Parallel Out Shift Register Implementation*/
///////////////////////////////////////////////////////////

module PIPO_Shift_Register(in, load, clock, clear, out);

input [3:0] in;
input load, clock, clear;
output [3:0] out;
reg [3:0] out;

always @(posedge clock or negedge clear) begin
	if (clear)
		out <= #1 4'b0;
	else begin
		out[3:0] <= #1 load ? in[3:0] : {out[2:0], 1'b0};
	end
end


endmodule



