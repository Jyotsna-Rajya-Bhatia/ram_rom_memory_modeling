`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2025 15:36:12
// Design Name: 
// Module Name: single_port_ram
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


module single_port_ram(
    input [7:0] data,
    input [5:0] addr,
    input write_enable,
    input clk,
    output [7:0] read
    );
    reg [7:0] single_ram [63:0];
    reg [5:0] addr_reg;
    
    always @ (posedge clk)
    begin
    if (write_enable)
    single_ram[addr] <= data;
    else 
    addr_reg <= addr;
    end
    
    assign read = single_ram [addr_reg];
endmodule

module dual_port_ram(
    input [7:0] a_data, b_data,
    input [5:0] a_addr, b_addr,
    input a_write_enable, b_write_enable,
    input clk,
    output reg [7:0] a_read, b_read     // assigned in always, single port used assign 
    );
    reg [7:0] dual_ram[63:0];
    
    
    always @ (posedge clk)
    begin
    if (a_write_enable)
    dual_ram[a_addr] <= a_data;
    else 
    a_read <= dual_ram[a_addr];
    end
    
    always @ (posedge clk)
    begin
    if (b_write_enable)
    dual_ram[b_addr] <= b_data;
    else 
    b_read <= dual_ram[b_addr];
    end

endmodule

module rom (
input clk,
input en,
input [5:0]addr,
output reg [7:0]data);

reg [7:0] mem[63:0];

always @ (posedge clk)
begin
if (en)
data <= mem[addr];
else 
data <= 8'h00;
end

initial 
begin
$readmemh ("mem_rom.hex", mem);   //load from notepad file
end

endmodule



