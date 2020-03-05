module rom(I, addr);
	output reg [15:0] I;
	input [7:0] addr;
	always @(addr) begin
		case (addr)
            //put instructions here
			8'h00: I = 16'h12;
			8'h01: I = 16'h43;
			8'h02: I = 16'h67;
			8'h03: I = 16'h98;
			8'h04: I = 16'h12;
			8'h05: I = 16'h43;
			8'h06: I = 16'h67;
			8'h07: I = 16'h98;
			8'h08: I = 16'h12;
			8'h09: I = 16'h43;
			8'h0A: I = 16'h67;
			8'h0B: I = 16'h98;
			default: I = 16'b0;
		endcase
	end
endmodule

