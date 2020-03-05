module ram(data, addr, cs, we, re);
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    parameter RAM_DEPTH = 1 << ADDR_WIDTH;
    parameter BASE_ADDR = 0;

    input cs, we, re;
    input [ADDR_WIDTH + BASE_ADDR - 1:0] addr;
    inout [DATA_WIDTH - 1:0] data;
    reg [DATA_WIDTH - 1:0] mem [0:RAM_DEPTH - 1];
	 reg [DATA_WIDTH - 1:0] data_out;
	 
	 assign data = (cs && !we && re) ? data_out : {DATA_WIDTH{1'bz}}; 

    always@* begin
	     if(cs && we) mem[addr] <= data;
		  data_out <= mem[addr];
    end
endmodule

/*
module ram(
clk         , // Clock Input
address     , // Address Input
data        , // Data bi-directional
cs          , // Chip Select
we          , // Write Enable/Read Enable
oe            // Output Enable
);

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;
parameter BASE_ADDR = 0;

//--------------Input Ports----------------------- 
input                  clk         ;
input [ADDR_WIDTH + BASE_ADDR - 1:BASE_ADDR] address     ;
input                  cs          ;
input                  we          ;
input                  oe          ; 

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data       ;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0] data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
reg                  oe_r;

//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1
assign data = (cs && oe && !we) ? data_out : {DATA_WIDTH{1'bz}}; 

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (negedge clk)
begin : MEM_WRITE
   if ( cs && we ) begin
       mem[address] = data;
   end
end

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
always @ (negedge clk)
begin : MEM_READ
  if (cs && !we && oe) begin
    data_out = mem[address];
    oe_r = 1;
  end else begin
    oe_r = 0;
  end
end

endmodule
*/

