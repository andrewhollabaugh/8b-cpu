module addr_detect(addr, out);
	input [7:0] addr;
	output out;
	parameter base_addr = 8'h00; // the address to detect
	parameter addr_mask = 8'hFF; // which bits to care about (1 means we care)
	
	assign out = ((address & address_mask) == base_address);
endmodule
