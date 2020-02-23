module rom(data, addr);
	output reg [15:0] out;
	input [7:0] addr;
	always @(addr) begin
		case (addr)
            //put instructions here
			8'h00: out = 16'h12;
			8'h01: out = 16'h43;
			8'h02: out = 16'h67;
			8'h03: out = 16'h98;
			default: out = 16'b0;
		endcase
	end
endmodule

