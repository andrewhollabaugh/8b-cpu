module register_nbit(clk, rst, l, Q, D);
	parameter N = 8; // number of bits
	input clk; // positive edge clock
	input rst; // positive logic asynchronous reset
	input l; // load enable
	input [N-1:0] D; // data input
	output reg [N-1:0] Q; // registered output
	
	always @(posedge clk or posedge rst) begin
		if(rst)
			Q <= 0;
		else if(l)
			Q <= D;
		else
			Q <= Q;
	end
endmodule

