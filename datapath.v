module datapath(clk, rst, data, addr, control_word, K, I, alu_status_latched, r0, r1, r2, r3, r4, r5, r6, r7);
	input clk, rst;
	inout [7:0] data;
    input [7:0] addr;
	input [21:0] control_word;
	input [7:0] K;
    output [15:0] I;
	output [3:0] alu_status_latched;
	output [7:0] r0, r1, r2, r3, r4, r5, r6, r7;
	
    wire sl, il, pcl, mr, mw, b_sel, a_sel, en_alu, ci, w;
	wire [2:0] DA, SA, SB, FS;

    assign control_word = {sl, il, pcl, mr, mw, b_sel, a_sel, en_alu, ci, FS, w, SB, SA, DA};
	
	wire [7:0] A_before_mux, A_after_mux, B_before_mux, B_after_mux, F, rom_addr;
    wire [15:0] rom_data;
	
    register_file register_file_inst(clk, rst, data, DA, w, SA, SB, A_before_mux, B_before_mux, r0, r1, r2, r3, r4, r5, r6, r7);
    alu alu_inst(A_after_mux, B_after_mux, FS, ci, F, alu_status);
	
    assign A_after_mux = a_sel ? rom_addr : A_before_mux;
    assign B_after_mux = b_sel ? K : B_before_mux;

	assign data = en_alu ? F : 8'bz;

	register_nbit alu_status_reg_inst(clk, rst, SL, alu_status, alu_status_latched);
	defparam alu_status_reg_inst.N = 4;

    rom rom_inst(rom_data, rom_addr);
	
    register_nbit program_reg_inst(clk, rst, pcl, data, rom_addr);
	defparam program_reg_inst.N = 8;
    
    register_nbit instruction_reg_inst(clk, rst, il, rom_data, I);
	defparam instruction_reg_inst.N = 16;
    
endmodule
