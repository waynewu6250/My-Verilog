/*Design a IC chip 74HC_HCT85 fabricated by Philips Semiconductor Corporation \n
  4-bit magnitude comparator Design*/

/*Basic Opration:
  Compare two 4-bit inputs A and B and return three output with each high at A>B, A<B, or A=B.
 */

 module com74HC_HCT85(A, B, 
 				   cascading_Alarger,
 				   cascading_Blarger,
 				   cascading_Equal,
 				   Alarger,
 				   Blarger,
 				   Equal);

 input [3:0] A,B;
 input cascading_Alarger, cascading_Blarger, cascading_Equal;
 output Alarger, Blarger, Equal;
 reg Alarger, Blarger, Equal;

 always @(A or B or cascading_Alarger or cascading_Blarger or cascading_Equal) begin
 	{Alarger, Blarger, Equal} = 3'd0;
 	if (A>B) begin
 		Alarger = 1'b0;
 	end
 	else begin
 		if (A<B) begin
 			Blarger = 1'b0;
 		end
 		else begin
 			case ({cascading_Alarger, cascading_Blarger, cascading_Equal})
 				3'b100 : Alarger = 1'b0;
 				3'b010 : Blarger = 1'b0;
 				3'b110 : {Alarger, Blarger, Equal} = 3'b000;
 				3'b000 : {Alarger, Blarger, Equal} = 3'b110;
 				default : {Alarger, Blarger, Equal} = 3'b011;
 			endcase 

 		end
 	end

 end

 endmodule
