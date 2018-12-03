// Implement a stack (LIFO) circuit

module sync_stack(clk, reset_n, data_in, push, pop, q);

parameter WIDTH = 11;
parameter DEPTH = 7;

input clk, reset_n, push, pop;
input [WIDTH-1:0] data_in;
output [WIDTH-1:0] q;

reg [WIDTH-1:0] mem[0:(1<<WIDTH)-1];
reg [DEPTH-1:0] ptr;
reg [WIDTH-1:0] q;

// Data in or out
always @(posedge clk) begin
	if (reset_n==1'b0) begin
		mem[ptr] <= #1 0;
		q <= #1 0;
	end
	else begin
		mem[ptr] <= #1 (push==1'b1) ? data_in : mem[ptr];
		q <= #1 (!push)&(pop) ? mem[ptr-1] : q;
	end
end


// Arrange ptr
always @(posedge clk) begin
	if (reset_n==1'b0) begin
		ptr <= #1 1'b0;
	end
	else begin
		if (push) begin
			ptr <= #1 ptr + 1;
		end
		else begin
			ptr <= #1 (pop==1'b1) ? ptr-1 : ptr;
		end
	end
end



endmodule