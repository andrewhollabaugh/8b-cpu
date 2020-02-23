module rom(out, address);
	output reg [15:0] out;
	input [7:0] address;
	always @(address) begin
		case (address)
            //put instructions here
			8'h00: out = 16'h1234;
			8'h01: out = 16'h4321;
			8'h02: out = 16'h6789;
			8'h03: out = 16'h9876;
			default: out = 16'h0000;
		endcase
	end
endmodule

