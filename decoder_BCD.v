module decoder_BCD (A, B, C, D, Disp);

input A, B, C, D;
output [6:0] Disp;
reg [6:0] Disp;
wire [3:0] BCD;

assign BCD = {D, C, B, A};
always @(BCD) begin
	case (BCD)
		4'b0000 : Disp = 7'b111_1110;
		4'b0001 : Disp = 7'b011_0000;
		4'b0010 : Disp = 7'b110_1101;
		4'b0011 : Disp = 7'b111_1001;
		4'b0100 : Disp = 7'b011_0011;
		4'b0101 : Disp = 7'b101_1011;
		4'b0110 : Disp = 7'b101_1111;
		4'b0111 : Disp = 7'b111_0000;
		4'b1000 : Disp = 7'b111_1111;
		4'b1001 : Disp = 7'b111_1011;

		default : Disp = 7'b000_0000;
	endcase

end

endmodule
	