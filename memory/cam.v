// Implement a content addressable memory circuit (CAM)

module cam(clk, enable, 
	       data_in, 
	       MatchEn, WriteEn,
	       WriteAddr,
	       MatchAddr, Match
	       );

input clk, enable;
input [15:0] data_in;
input MatchEn, WriteEn;
input [7:0] WriteAddr;
output [7:0] MatchAddr;
output Match;

reg [15:0] mem[255:0];
reg Equal, Hit, Match;
reg [7:0] HitAddr, MatchAddr;
integer i;


//Write Operations
always @(posedge clk) begin
	if ((enable==1'b1) && (WriteEn==1'b1))
		mem[WriteAddr] <= #1 data_in;
end

//Search & Compare
always @* begin
	Hit = 1'b0;
	HitAddr = 8'd0;
	
	if (MatchEn==1'b1) begin
		for(i=0;i<256;i=i+1) begin
			Equal = (mem[i]==data_in) ? 1'b1: 1'b0;
			if ((Equal==1'b1) && (Hit==1'b0)) begin
				Hit = 1'b1;
				HitAddr = i;
			end
			else begin
				Hit = Hit;
				HitAddr = HitAddr;
			end
		end
	end
	else begin
		Hit = Hit;
		HitAddr = HitAddr;
	end

end

//Assign Values
always @(posedge clk) begin
	if(enable==1'b0) begin
		Match <= #1 1'b0;
		MatchAddr <= #1 8'd0;
	end
	else begin
		Match <= #1 Hit;
		MatchAddr <= #1 HitAddr;
	end
end

endmodule