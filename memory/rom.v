// Read-Only Memory Design

module rom(addr, data_out);

input [2:0] addr;
output [3:0] data_out;
reg [3:0] rom[0:7];
wire [3:0] data_out;

/* $readmemb: use binary format
   $readmemh: use hexadecimal format*/
initial $readmemb("rom.data", rom);
assign data_out = rom[addr];

endmodule

