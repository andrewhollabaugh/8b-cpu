module register_nbit(Q, D, l, r, clk);
	parameter N = 8; // number of bits
	output reg [N-1:0] Q; // registered output
	input [N-1:0] D; // data input
	input l; // load enable
	input r; // positive logic asynchronous reset
	input clk; // positive edge clock
	
	always @(posedge clk or posedge r) begin
		if(r)
			Q <= 0;
		else if(l)
			Q <= D;
		else
			Q <= Q;
	end
endmodule

