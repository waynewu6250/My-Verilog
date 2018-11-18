module test(a, b, o);
input a,b;
output o;
reg [8*21:0] string;
initial begin
	string = "It is a simple string";
	$display("%s\n",string);
end
endmodule