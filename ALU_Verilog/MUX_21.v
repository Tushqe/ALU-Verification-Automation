`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 09:29:19 AM
// Design Name: 
// Module Name: MUX_21
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


module MUX_21(
input wire in0, 
input wire in1,
input wire s,
output wire y 
    );
    assign y = (in0&~s) | (in1&s);
endmodule
