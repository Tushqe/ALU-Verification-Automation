`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2024 09:33:31 PM
// Design Name: 
// Module Name: BitSlice
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


module BitSlice(
    input A,
    input B,
    input Cin,
    input K2,
    input K1,
    input K0,
    output Y,
    output Cout
    );
    wire LAS, LS1, LS0, AS1, AS0;
    wire LogicY, ArithY;
    assign AS1 = K1; 
    assign AS0 = K0; 
    assign LS1 = K1;
    assign LS0 = K0;
    assign LAS = K2;
   
    
    ArithBlk arith_blk(.S1(AS1), .S0(AS0), .A(A), .B(B), .C(Cin), .Y(ArithY), .CO(Cout)); 
    LogicBlk logic_blk(.a(A), .b(B), .s0(LS0), .s1(LS1), .y(LogicY)); 
    MUX_21 mux_bitslice(.in0(LogicY), .in1(ArithY), .s(LAS), .y(Y)); 
    
    
    
    
endmodule
