/*This is the example for a full adder implementation
  with a submodule to cover sophisticated submodule inside*/


module Fadd(a, b, cin, s, cout);

input a, b, cin;
output s, cout;

assign {s, cout} = a+b+cin;

endmodule

//--------------------------------------

module FullAdder(r1, r2, cin, s, cout);

input [3:0] r1,r2;
input cin;
output [3:0] s;
output cout;


//implicit call
//Fadd u0(r1[0],r2[0],ci,s[0],c1);
//Fadd u1(r1[1],r2[1],c1,s[1],c2);
//Fadd u2(r1[2],r2[2],c2,s[2],c3);
//Fadd u3(r1[3],r2[3],c3,s[3],cout);

//explicit call
Fadd u0(
.a (r1[0]),
.b (r2[0]),
.cin (ci),
.s (s[0]),
.cout (c1)
);

Fadd u1(
.a (r1[1]),
.b (r2[1]),
.cin (c1),
.s (s[1]),
.cout (c2)
);

Fadd u2(
.a (r1[2]),
.b (r2[2]),
.cin (c2),
.s (s[2]),
.cout (c3)
);

Fadd u3(
.a (r1[3]),
.b (r2[3]),
.cin (c3),
.s (s[3]),
.cout (cout)
);

endmodule


