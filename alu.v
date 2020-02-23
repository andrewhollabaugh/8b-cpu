module alu(A, B, FS, ci, F, status);
	input [7:0] A, B;
	input [2:0] FS;
	// FS - function select
	//   000 - AND
	//   001 - OR
	//   010 - ADD
	//   011 - SUB
	//   100 - shift left
	//   101 - shift right
	//   110 - XOR

	input ci;
	output [7:0] F;
	output [3:0] status;
	
	wire Z, N, C, V;
	assign status = {V, C, N, Z};
	
	wire [7:0] B_signal;
	assign B_signal = FS[0] & FS[1] ? ~B : B;
	
	assign N = F[7];
	
	assign Z = (F == 8'b0) ? 1'b1 : 1'b0;
	
	assign V = ~(A[7] ^ B_signal[7]) & (F[7] ^ A[7]);
	
	wire [7:0] and_output, or_output, xor_output, add_output, shift_left, shift_right;
	assign and_output = A & B_signal;
	assign or_output = A | B_signal;
	assign xor_output = A ^ B_signal;
	adder adder(A, B_signal, ci, add_output, C);
	shifter shift_inst(A, B[2:0], shift_left, shift_right);
	
	mux8to1nbit main_mux(F, FS, and_output, or_output, add_output, add_output, shift_left, shift_right, xor_output, 8'b0);

endmodule

module shifter(in, shift_amount, left, right);
	input [7:0] in;
	input [2:0] shift_amount;
	output [7:0] left, right;
	
	assign left = in << shift_amount;
	assign right = in >> shift_amount;
endmodule

module adder(A, B, ci, S, co);
	input [7:0] A, B;
	input ci;
	output [7:0] S;
	output co;
	
	wire [8:0] carry;
	assign carry[0] = ci;
	
	// use generate block to instantiate 8 full adders
	genvar i;
	generate
	for (i=0; i<8; i=i+1) begin: full_adders // blocks within a generate block need to be named
		full_adder adder_inst(A[i], B[i], carry[i], S[i], carry[i+1]);	
	end
	endgenerate
	// this will generate the following code:
	// FullAdder full_adders[0].adder_inst (S[0], carry[1], A[0], B[0], carry[0]);
	// FullAdder full_adders[1].adder_inst (S[1], carry[2], A[1], B[1], carry[1]);
	// ...
	// FullAdder full_adders[63].adder_inst (S[63], carry[64], A[63], B[63], carry[63]);
	
	assign co = carry[8];
endmodule

module full_adder(a, b, ci, s, co);
	input a, b, ci;
	output s, co;
	
	assign s = a ^ b ^ ci;
	assign co = a&b | a&ci | b&ci;
endmodule

