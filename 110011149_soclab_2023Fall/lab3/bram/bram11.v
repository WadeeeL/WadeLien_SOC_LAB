// bram behavior code (can't be synthesis)
// 11 words
module bram11 
(
    CLK,
    WE,
    EN,
    Di,
    Do,
    A
);

    input   wire            CLK;
    input   wire    [3:0]   WE;
    input   wire            EN;
    input   wire    [31:0]  Di;
    output  wire     [31:0]  Do;
    input   wire    [11:0]   A; //address

    //  11 words
	reg [31:0] RAM[0:10]; 
    reg [11:0] r_A; //address

    always @(posedge CLK) begin // synchronous read 
        r_A <= A;
    end

    assign Do =RAM[(A>>2)];   // read

    reg [31:0] Temp_D;
    always @(posedge CLK) begin // synchronous write
        if(EN) begin
            //When WE = 4'b1111 , can write 4 bytes data in 
	        if(WE[0]) RAM[(A>>2)][7:0] <= Di[7:0];
            if(WE[1]) RAM[(A>>2)][15:8] <= Di[15:8];
            if(WE[2]) RAM[(A>>2)][23:16] <= Di[23:16];
            if(WE[3]) RAM[(A>>2)][31:24] <= Di[31:24];
        end
    end

endmodule
