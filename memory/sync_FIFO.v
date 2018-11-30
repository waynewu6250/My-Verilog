// Design a synchronous FIFO memory circuit

module sync_FIFO(clk, reset_n, DataIn, DataOut, WE, RE, Full, Empty, Half);

input clk, reset_n, WE, RE;
input [15:0] DataIn;
output [15:0] DataOut;
output Full, Empty, Half;

reg [15:0] DataOut;
reg [3:0] read_ptr, write_ptr, counter;
reg [15:0] Mem;
wire Full, Empty, Half;

always @(posedge clk) begin
	if (reset_n == 1'b0) begin
		read_ptr <= #1 4'd0;
		write_ptr <= #1 4'b0;
		counter <= #1 4'd0;
		DataOut <= #1 15'd0;
	end
	else begin
		case({RE, WE})
			// No read or write
			(2'b00): counter <= #1 counter;
			// Write
			(2'b01): begin
				Mem[write_ptr] <= #1 DataIn[15:0];
				counter <= #1 counter + 1;
				write_ptr <= #1 (write_ptr == 15) ? 4'b0 : (write_ptr + 1);
			end
			// Read
			(2'b10): begin
				DataOut <= #1 Mem[read_ptr];
				counter <= #1 counter + 1;
				read_ptr <= #1 (read_ptr == 15) ? 4'b0 : (read_ptr + 1);
			end
			//
			(2'b11): begin
				Mem[write_ptr] <= #1 DataIn[15:0];
				DataOut <= #1 Mem[read_ptr];
				write_ptr <= #1 (write_ptr == 15) ? 4'b0 : (write_ptr + 1);
				read_ptr <= #1 (read_ptr == 15) ? 4'b0 : (read_ptr + 1);
			end
		endcase

	end
end

assign Full = (counter==15) ? 1'b1: 1'b0;
assign Empty = (counter==0) ? 1'b1: 1'b0;
assign Half = (counter==8) ? 1'b1: 1'b0;

endmodule
