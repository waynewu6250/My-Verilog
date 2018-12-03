// Implement an aynchronous FIFO with encoder-decoder structures
// Do data transfer, then assign pointer and counter

module async_FIFO(
	reset_n,
	
	// write operation
	wr_clk,
	wr_enable,
	wr_data,
	wr_full,
	wr_empty,
	wr_half,

	// read operation
	rd_clk,
	rd_enable,
	rd_data,
	rd_full,
	rd_empty,
	rd_half
	);

input reset_n, wr_clk, rd_clk, wr_enable, rd_enable;
input [7:0] wr_data;
output [7:0] rd_data;
output wr_full, wr_empty, wr_half,
	   rd_full, rd_empty, rd_half;

reg [7:0] rd_data;
wire wr_full, wr_empty, wr_half,
	 rd_full, rd_empty, rd_half;

reg [7:0] Mem [15:0];
wire [3:0] wr_ptr, rd_ptr;

////////////////////////////////////////////
//Special Control for grey-binary conversion
wire [3:0] PushBinCnt_wrClk,
		   PopBinCnt_wrClk,
		   PopBinCnt_rdClk,
		   PushBinCnt_rdClk;

wire [4:0] cnt_wrClk,
		   cnt_rdClk;
////////////////////////////////////////////


//Write Operation
assign PushFifo_enable = (wr_enable==1'b1) & (wr_full==1'b0);
always @(posedge wr_clk) begin
	Mem[wr_ptr] <= #1 (PushFifo_enable) ? wr_data : Mem[wr_ptr];
end
//Read operation
assign PopFifo_enable = (rd_enable==1'b1) && (rd_empty==1'b0);
always @(posedge rd_clk) begin
	rd_data <= #1 (PopFifo_enable) ? Mem[wr_ptr] : rd_data;
end

//use Gray Count for wr_ptr, rd_ptr
//use Binary Count for 4 counters
Binary2Gray Binary2Gray_WrPtr(
			.Clk      	(wr_clk),
			.Reset_n  	(reset_n),
			.Enable_in 	(PushFifo_enable),
			.BinCount  	(PushBinCnt_wrClk[3:0]),
			.GrayCount 	(wr_ptr[3:0])
			);
Binary2Gray Binary2Gray_RdPtr(
			.Clk      	(rd_clk),
			.Reset_n  	(reset_n),
			.Enable_in 	(PopFifo_enable),
			.BinCount  	(PopBinCnt_rdClk[3:0]),
			.GrayCount 	(rd_ptr[3:0])
			);
Gray2Binary Gray2Binary_WrPtr(
			.Clk     	(rd_clk),
			.GrayCount  (wr_ptr[3:0]),
			.BinCount	(PushBinCnt_rdClk[3:0])
			);
Gray2Binary Gray2Binary_RdPtr(
			.Clk     	(wr_clk),
			.GrayCount  (rd_ptr[3:0]),
			.BinCount	(PopBinCnt_wrClk[3:0])
			);
// Use different clock to avoid metastate (calculate again)
assign cnt_wrClk = {1'b0,PushBinCnt_wrClk[3:0]}-{1'b0,PopBinCnt_wrClk[3:0]};
assign cnt_rdClk = {1'b0,PushBinCnt_rdClk[3:0]}-{1'b0,PopBinCnt_rdClk[3:0]};

assign wr_full = cnt_wrClk > 4'd12;
assign wr_empty = cnt_wrClk < 4'd3;
assign wr_half = cnt_wrClk > 4'd7;
assign rd_full = cnt_rdClk > 4'd12;
assign rd_empty = cnt_rdClk < 4'd3;
assign rd_half = cnt_rdClk > 4'd7;

endmodule


//Auxuliary Function
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//calculate bincount first and convert it to graycount and send to wr_ptr, rd_ptr from GrayCount
module Binary2Gray(Clk, Reset_n, Enable_in, BinCount, GrayCount);

input Clk, Reset_n, Enable_in;
output [3:0] BinCount, GrayCount;
reg [3:0] BinCount, GrayCount;

always @(posedge Clk or negedge Reset_n) begin
	if(Reset_n == 1'b0) begin
		BinCount <= #1 4'd1;
		GrayCount <= #1 4'd0;
	end
	else if (Enable_in == 1'b1) begin
		BinCount <= #1 BinCount + 1;
		//bin2gray conversion
		GrayCount[3] <= #1 BinCount[3];
		GrayCount[2] <= #1 BinCount[3] ^ BinCount[2];
		GrayCount[1] <= #1 BinCount[2] ^ BinCount[1];
		GrayCount[0] <= #1 BinCount[1] ^ BinCount[0];
	end

end

endmodule
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//convert graycount back to bincount
module Gray2Binary(Clk, GrayCount, BinCount);

input Clk;
input [3:0] GrayCount;
output [3:0] BinCount;
reg [3:0] Gray_temp, Gray_clk;
wire [3:0] BinCount;

always @(posedge Clk) begin
	Gray_temp <= #1 GrayCount;
	Gray_clk <= #1 Gray_temp;
end

assign BinCount[3] = Gray_clk[3];
assign BinCount[2] = Gray_clk[3] ^ Gray_clk[2];
assign BinCount[1] = Gray_clk[3] ^ Gray_clk[2] ^ Gray_clk[1];
assign BinCount[0] = Gray_clk[3] ^ Gray_clk[2] ^ Gray_clk[1] ^ Gray_clk[0];

endmodule
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

