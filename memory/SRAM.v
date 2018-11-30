// Implement an asynchronous SRAM memory circuit
// No clock

module async_SRAM(Address, Data, CS, WE, OE);

parameter AddressSize = 8;
parameter DataSize = 16;

input [AddressSize-1:0] Address;
inout [DataSize-1:0] Data; //In or Out at the same place
input CS; //1-bit low-active chip selection
input OE; //1-bit low-active output enable
input WE; //1-bit low-active wordline


reg [DataSize-1:0] Mem [0:1<<AddressSize]; //Define SRAM size
wire q;

// Read operations
assign Data = (!CS && !OE) ? Mem[Address] : {DataSize{1'bz}};

// Write operations
always @(CS or WE) begin
	if(!CS && !WE)
		Mem[Address] = Data;
end

// Make sure Wire and Output shouldn't be both low active
always @(OE or WE) begin
	if (!OE && !WE)
		$display("Operational Error in SRAM: OE and WE both active");
end

endmodule



///////////////////////////////////////////////
// Implement an synchronous SRAM memory circuit
// clock enable

module sync_SRAM(Address, Data, clk, WE, q);

parameter AddressSize = 8;
parameter DataSize = 16;

input [AddressSize-1:0] Address;
input [DataSize-1:0] Data;
input clk, WE;
output [DataSize-1:0] q;

reg [DataSize-1:0] Mem [0:1<<AddressSize]; //Define SRAM size
reg [AddressSize-1:0] addr_reg;

always @(posedge clk) begin
	// Write operations else just read the current data at the address
	if (!WE)
		Mem[Address] <= #1 Data;
	addr_reg <= #1 Address;

end

assign q = Mem[addr_reg];

endmodule







