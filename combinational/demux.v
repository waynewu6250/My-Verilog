//This is an example of a 1 to 4 demultiplexer

module demux(D, S, Y);

parameter SIZE = 2;
input D;
input [SIZE-1:0] S;
output [2**SIZE-1:0] Y;
reg [2**SIZE-1:0] Y;


always @(D or S) begin
	case (S)
		(2'b00) : Y = 4'b1000;
		(2'b00) : Y = 4'b0100;
		(2'b00) : Y = 4'b0010;
		(2'b00) : Y = 4'b0001;
		default : Y = 4'b0000;
	endcase

end

endmodule