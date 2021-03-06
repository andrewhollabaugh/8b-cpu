//datapath with memory interface; includes ram and peripherals
module datapath_mi(clk, rst, data, control_word, K, I, alu_status, r0, r1, r2, r3, r4, r5, r6, r7);
	input clk, rst;
	input [21:0] control_word;
	input [7:0] K;
    output [15:0] I;
	output [3:0] alu_status;
	output [7:0] data, r0, r1, r2, r3, r4, r5, r6, r7;
	
    wire mw, mr;
    assign mw = control_word[17];
    assign mr = control_word[18];
	
    wire [7:0] addr;
	datapath datapath_inst(clk, rst, data, addr, control_word, K, I, alu_status, r0, r1, r2, r3, r4, r5, r6, r7);
	
	wire ram_cs;
    addr_detect ram_addr_detect_inst(addr, ram_cs);
    defparam ram_addr_detect_inst.base_addr = 8'b0;
    defparam ram_addr_detect_inst.addr_mask = 8'b10000000; //from 0 to 127 of address space is RAM
    
	ram ram_inst(data, addr, ram_cs, mw, mr);
	defparam ram_inst.DATA_WIDTH = 8;
	defparam ram_inst.ADDR_WIDTH = 8;
	defparam ram_inst.BASE_ADDR = 0;
	
endmodule

