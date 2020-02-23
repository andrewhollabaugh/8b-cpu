module register_file(clk, rst, D, DA, w, SA, SB, A, B, r0, r1, r2, r3, r4, r5, r6, r7);
    input clk, rst, w;
	input [7:0] D; // Data input
	input [2:0] DA, SA, SB; // Select A - A Address
	output [7:0] A; // A bus
	output [7:0] B; // B bus
	output [7:0] r0, r1, r2, r3, r4, r5, r6, r7; // outputs for visualization
	
	wire [7:0] load_enable;
	decoder_3x8 decoder(load_enable, DA, w);
	
	// create 8-bit wires for each register
	wire [7:0] R0, R1, R2, R3, R4, R5, R6, R7;
	
	// instantiate 8 registers
	register_nbit reg0 (clk, rst, load_enable[0], D, R0);
	register_nbit reg1 (clk, rst, load_enable[1], D, R1);
	register_nbit reg2 (clk, rst, load_enable[2], D, R2);
	register_nbit reg3 (clk, rst, load_enable[3], D, R3);
	register_nbit reg4 (clk, rst, load_enable[4], D, R4);
	register_nbit reg5 (clk, rst, load_enable[5], D, R5);
	register_nbit reg6 (clk, rst, load_enable[6], D, R6);
	assign R7 = 8'b0;
	
	// set the number of bits for each register to 8
	defparam reg0.N = 8;
	defparam reg1.N = 8;
	defparam reg2.N = 8;
	defparam reg3.N = 8;
	defparam reg4.N = 8;
	defparam reg5.N = 8;
	defparam reg6.N = 8;
	
	mux8to1nbit mux_a(A, SA, R0, R1, R2, R3, R4, R5, R6, R7);
	mux8to1nbit mux_b(B, SB, R0, R1, R2, R3, R4, R5, R6, R7);

	// set the number of bits for the mux
	defparam mux_a.N = 8;
	defparam mux_b.N = 8;
	
    assign r0 = R0;
    assign r1 = R1;
    assign r2 = R2;
    assign r3 = R3;
    assign r4 = R4;
    assign r5 = R5;
    assign r6 = R6;
    assign r7 = R7;
	
endmodule

