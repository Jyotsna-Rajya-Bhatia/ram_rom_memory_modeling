`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2025 13:18:02
// Design Name: 
// Module Name: single_port_ram_testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module single_port_ram_testbench;
reg [7:0]data;
reg [5:0]addr;
reg write_enable;
reg clk;
wire [7:0]read;

single_port_ram dut( .data(data), .addr(addr), .write_enable(write_enable), .clk(clk), .read (read));

initial
begin
clk = 1'b1;
forever #5 clk = ~clk;
end

initial
begin
 $display("Time\tWE\tADDR\tWRITE_DATA\tREAD_DATA");
write_enable = 1'b1;
data = 8'h01;
addr = 6'd0;

#10;
data = 8'h02;
addr = 6'h1;

#10;
write_enable = 1'b0;
addr = 6'd0;

#10;
addr = 6'd2;

#10;
write_enable = 1'b1;
data = 8'h06;
addr = 6'd1;

 //writing at the same port (overwrite)
write_enable = 1'b1;
data = 8'hAA;
addr = 6'd2;  //one data at 02
#10;
data = 8'h55;
addr = 6'd2;   //2nd data at 02
#10;
write_enable = 1'b0;
addr = 6'd2;       //this will read data at 02         
#10;

//undefined data at addr
addr = 6'd5;                
#10;
end

endmodule

module dual_port_ram_testbench;
    reg [7:0] a_data, b_data;
    reg [5:0] a_addr, b_addr;
    reg a_write_enable, b_write_enable;
    reg clk;
    wire [7:0] a_read, b_read;
    
    dual_port_ram dut ( .a_data(a_data), .b_data(b_data), .a_addr(a_addr), .b_addr(b_addr), .a_write_enable(a_write_enable), .b_write_enable(b_write_enable), .clk(clk), .a_read(a_read), .b_read(b_read));
    
    initial 
    begin
    clk = 1'b1;
    forever #5 clk = ~clk;
    end
    
    initial 
    begin
    $display("Time\tA_WE\tA_ADDR\tA_WR_DATA\tA_RD\t|\tB_WE\tB_ADDR\tB_WR_DATA\tB_RD");
    
    a_data = 8'h33;
    a_addr = 6'h01;
    b_data = 8'h44;
    b_addr = 6'h02;
    a_write_enable = 1'b1;
    b_write_enable = 1'b1;
    
    
    #10;
    a_data = 8'h55;
    a_addr = 6'h03;
    b_data = 8'h01;
    b_write_enable = 1'b0;
    
    #10;
    a_addr = 6'h02;
    b_addr = 6'h01;
    a_write_enable = 1'b0;
    
    #10;
    a_addr = 6'h01;
    b_addr = 6'h02;
    b_data = 8'h77;
    b_write_enable = 1'b1;
    #10;
    end
    endmodule
    
    module rom_testbench;
    reg clk;
    reg en;
    reg [5:0]addr;
    wire [7:0]data;   //rom, so data is output here 
    
    rom dut( .clk(clk), .en(en), .addr(addr), .data(data));
    
    initial 
    begin
    clk = 1'b1;
    forever #5 clk = ~clk;
    end
    
    initial
    begin
    $display("Time\tEN\tADDR\tROM_DATA");
    
    en = 1'b0;
    
    #10;
    en = 1'b1;
    addr = 6'h1a;
    
    #10;
    addr = 6'h0e;
    
    #10;
    en = 1'b0;
    addr = 6'h00;
    
    #10;
    en  = 1'b1;
    addr = 6'h26;
    
    #10;
    addr = 6'h3f;
    
    end
  
endmodule
