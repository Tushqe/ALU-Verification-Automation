`timescale 1ns / 1ps

module ALU_8b_tb;

    reg  [7:0] A;
    reg  [7:0] B;
    reg        K2;
    reg        K1;
    reg        K0;

    wire [7:0] Y;
    wire       Cout;

    ALU_8b dut (
        .A(A),
        .B(B),
        .K2(K2),
        .K1(K1),
        .K0(K0),
        .Y(Y),
        .Cout(Cout)
    );

    task apply_test;
        input [7:0] a_in;
        input [7:0] b_in;
        input       k2_in;
        input       k1_in;
        input       k0_in;
        begin
            A  = a_in;
            B  = b_in;
            K2 = k2_in;
            K1 = k1_in;
            K0 = k0_in;
            #10;
            $display("time=%0t | K=%b%b%b | A=%h | B=%h | Y=%h | Cout=%b",
                     $time, K2, K1, K0, A, B, Y, Cout);
        end
    endtask

    initial begin
        // Initialize
        A = 8'h00; B = 8'h00; K2 = 0; K1 = 0; K0 = 0;
        #10;

        // -------------------------
        // LOGIC MODE SCAN (K2 = 0)
        // Use values that make outputs easy to distinguish
        // A = 0x5A = 01011010
        // B = 0x3C = 00111100
        // ~A   = A5
        // A^B  = 66
        // A&B  = 18
        // A|B  = 7E
        // -------------------------
        apply_test(8'h5A, 8'h3C, 1'b0, 1'b0, 1'b0);
        apply_test(8'h5A, 8'h3C, 1'b0, 1'b0, 1'b1);
        apply_test(8'h5A, 8'h3C, 1'b0, 1'b1, 1'b0);
        apply_test(8'h5A, 8'h3C, 1'b0, 1'b1, 1'b1);

        // -------------------------
        // ARITHMETIC MODE SCAN (K2 = 1)
        // Likely candidates:
        // A+B  = 96
        // A    = 5A
        // A-B  = 1E
        // A+1  = 5B
        // -------------------------
        apply_test(8'h5A, 8'h3C, 1'b1, 1'b0, 1'b0);
        apply_test(8'h5A, 8'h3C, 1'b1, 1'b0, 1'b1);
        apply_test(8'h5A, 8'h3C, 1'b1, 1'b1, 1'b0);
        apply_test(8'h5A, 8'h3C, 1'b1, 1'b1, 1'b1);

        // Extra arithmetic edge checks
        apply_test(8'hFF, 8'h01, 1'b1, 1'b0, 1'b0); // add with carry out
        apply_test(8'h10, 8'h01, 1'b1, 1'b1, 1'b0); // subtraction example
        apply_test(8'hFF, 8'h00, 1'b1, 1'b1, 1'b1); // increment rollover

        #20;
        $finish;
    end

endmodule