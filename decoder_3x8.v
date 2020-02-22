module decoder_3x8(m, s, en);
	input [2:0] s; // select
	input en; // enable (positive logic)
	output [7:0] m;
	
    always @(s or en) begin
        if(en) begin
            case(s)
                3'b000: m <= 8'b00000001;
                3'b001: m <= 8'b00000010;
                3'b010: m <= 8'b00000100;
                3'b011: m <= 8'b00001000;
                3'b100: m <= 8'b00010000;
                3'b101: m <= 8'b00100000;
                3'b110: m <= 8'b01000000;
                3'b111: m <= 8'b10000000;
                default: m <= 8'b0;
            endcase
        end
        else m <= 8'b0;
    end
endmodule

