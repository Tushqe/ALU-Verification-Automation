`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2024 11:29:59 PM
// Design Name: 
// Module Name: LogicBlk
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


module LogicBlk(
a,b,s0,s1,y
    );
    input a,b,s0,s1;
    output y; 
    wire inva;
    wire xorab;
    wire andab;
    wire orab;
    assign inva = ~a;  
    assign xorab = a^b;  
    assign andab = a&b; 
    assign orab = a|b;
    MUX_41 logicblock(.a(inva), .b(xorab), .c(andab), .d(orab), .s0(s0), .s1(s1), .out(y));
endmodule
