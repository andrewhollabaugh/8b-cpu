module datapath_mi_tb();
    reg clk, rst;
    reg [21:0] control_word;
    reg [7:0] K;
    wire [7:0] data;
    wire [15:0] I;
    wire [3:0] alu_status;
    wire [7:0] r0, r1, r2, r3, r4, r5, r6, r7;

    datapath_mi dut(clk, rst, data, control_word, K, I, alu_status, r0, r1, r2, r3, r4, r5, r6, r7);

    always #5 clk <= ~clk;

    initial begin
        clk <= 1'b0;
        rst <= 1'b0;
        control_word <= 22'b0;
        K <= 8'b0;

        #10
        rst <= 1'b1;
        #20
        rst <= 1'b0;
        #10

        //MOV R0, #4
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____1_____0_____1____0__001_1_000_111_000;
        K <= 8'd4;
        #10

        //MOV R1, #2
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____1_____0_____1____0__001_1_000_111_001;
        K <= 8'd2;
        #10

        //ADD R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__010_1_001_000_010;
        #10

        //SUB R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____1__011_1_001_000_010;
        #10

        //ADDS R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b1__0___0__0__0____0_____0_____1____0__010_1_001_000_010;
        #10

        //SUBS R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b1__0___0__0__0____0_____0_____1____1__011_1_001_000_010;
        #10

        //AND R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__000_1_001_000_010;
        #10

        //ANDS R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b1__0___0__0__0____0_____0_____1____0__000_1_001_000_010;
        #10

        //OR R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__001_1_001_000_010;
        #10

        //XOR R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__110_1_001_000_010;
        #10

        //SL R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__100_1_001_000_010;
        #10

        //SR R2, R0, R1
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____0_____1____0__101_1_001_000_010;
        #10

        //ST R0, #3 
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__1____0_____0_____1____0__001_0_111_000_010;
        K <= 8'd3;
        #10

        //LD R3, #3
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__1__0____0_____0_____0____0__000_1_000_000_011;
        K <= 8'd3;
        #10

        //PCST R4
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____1_____1____1__010_1_111_000_100;
        #10

        //IF
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__1___1__0__0____0_____1_____1____1__010_0_111_000_000;
        #10

        //PCST R4
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____1_____1____1__010_1_111_000_100;
        #10

        //B #2 
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___1__0__0____1_____1_____1____1__010_0_000_000_000;
        K <= 8'd2;
        #10

        //PCST R4
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____1_____1____1__010_1_111_000_100;
        #10

        //BR R2
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___1__0__0____0_____0_____1____0__001_0_111_010_000;
        #10

        //PCST R4
        //              sl il pcl mr mw b_sel a_sel en_alu ci FS  w SB  SA  DA
        control_word <= 22'b0__0___0__0__0____0_____1_____1____1__010_1_111_000_100;
        #20
        $stop;
    end
endmodule

