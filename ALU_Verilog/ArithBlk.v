`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/19/2024 09:43:19 AM
// Design Name: 
// Module Name: ArithBlk
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


module ArithBlk(
 input S1,
 input S0,
 input A, 
 input B, 
 input C, 
 output Y, 
 output CO 
    );
    wire mux2_in0;
    wire fa_B; 
  
    wire B_inv; 
    wire gnd = 1'b0;
    
    assign B_inv = ~B;
    
    MUX_21 mux_b(.in0(B), .in1(B_inv), .s(S1), .y(mux2_in0));
    MUX_21 mux_y(.in0(mux2_in0), .in1(gnd), .s(S0), .y(fa_B));
    FullAdder full_adder(.A(A), .B(fa_B), .Cin(C), .S(Y), .Cout(CO));
    
   
    
    
endmodule
