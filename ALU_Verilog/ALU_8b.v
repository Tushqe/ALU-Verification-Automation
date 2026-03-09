`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2024 08:56:19 AM
// Design Name: 
// Module Name: ALU_8b
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


module ALU_8b(
    input [7:0] A, 
    input [7:0] B, 
    input K2, 
    input K1,
    input K0, 
    output [7:0] Y, 
    output Cout 
     );
     wire [7:0]carry; 
     BitSlice bit0(.A(A[0]), .B(B[0]), .Cin(K1), .K2(K2), .K1(K1), .K0(K0), .Y(Y[0]), .Cout(carry[0]));
      BitSlice bit1(.A(A[1]), .B(B[1]), .Cin(carry[0]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[1]), .Cout(carry[1]));
      BitSlice bit2(.A(A[2]), .B(B[2]), .Cin(carry[1]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[2]), .Cout(carry[2]));
      BitSlice bit3(.A(A[3]), .B(B[3]), .Cin(carry[2]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[3]), .Cout(carry[3]));
      BitSlice bit4(.A(A[4]), .B(B[4]), .Cin(carry[3]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[4]), .Cout(carry[4]));
      BitSlice bit5(.A(A[5]), .B(B[5]), .Cin(carry[4]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[5]), .Cout(carry[5]));
      BitSlice bit6(.A(A[6]), .B(B[6]), .Cin(carry[5]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[6]), .Cout(carry[6]));
      BitSlice bit7(.A(A[7]), .B(B[7]), .Cin(carry[6]), .K2(K2), .K1(K1), .K0(K0), .Y(Y[7]), .Cout(carry[7]));
  assign Cout = carry[7];           
endmodule
