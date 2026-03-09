`timescale 1ns / 1ps

module ALU_8b_auto_tb;

    // DUT inputs
    reg  [7:0] A;
    reg  [7:0] B;
    reg        K2;
    reg        K1;
    reg        K0;

    // DUT outputs
    wire [7:0] Y;
    wire       Cout;

    // Expected values from vector file
    reg  [7:0] exp_y;
    reg        exp_cout;
    reg        check_cout;

    // File and bookkeeping
    integer vec_file;
    integer status;
    integer test_count;
    integer fail_count;

    // Instantiate DUT
    ALU_8b dut (
        .A(A),
        .B(B),
        .K2(K2),
        .K1(K1),
        .K0(K0),
        .Y(Y),
        .Cout(Cout)
    );

    initial begin
        // Initialize
        A = 8'h00;
        B = 8'h00;
        K2 = 1'b0;
        K1 = 1'b0;
        K0 = 1'b0;
        exp_y = 8'h00;
        exp_cout = 1'b0;
        check_cout = 1'b0;
        test_count = 0;
        fail_count = 0;

        // Open vector file
        vec_file = $fopen("test_vectors.txt", "r");

        if (vec_file == 0) begin
            $display("ERROR: Could not open test_vectors.txt");
            $finish;
        end

        $display("==============================================");
        $display("Starting ALU_8b automated regression...");
        $display("Format: A B K2 K1 K0 EXP_Y EXP_COUT CHECK_COUT");
        $display("==============================================");

        // Read until end of file
        while (!$feof(vec_file)) begin
            status = $fscanf(vec_file, "%h %h %b %b %b %h %b %b\n",
                             A, B, K2, K1, K0, exp_y, exp_cout, check_cout);

            // Only process well-formed lines
            if (status == 8) begin
                test_count = test_count + 1;

                // Allow combinational outputs to settle
                #1;

                if (Y !== exp_y) begin
                    fail_count = fail_count + 1;
                    $display("FAIL [%0d] Y mismatch | A=%h B=%h K=%b%b%b | Y=%h EXP_Y=%h | Cout=%b EXP_Cout=%b CHECK_COUT=%b",
                             test_count, A, B, K2, K1, K0, Y, exp_y, Cout, exp_cout, check_cout);
                end
                else if (check_cout && (Cout !== exp_cout)) begin
                    fail_count = fail_count + 1;
                    $display("FAIL [%0d] Cout mismatch | A=%h B=%h K=%b%b%b | Y=%h EXP_Y=%h | Cout=%b EXP_Cout=%b",
                             test_count, A, B, K2, K1, K0, Y, exp_y, Cout, exp_cout);
                end
                else begin
                    $display("PASS [%0d] | A=%h B=%h K=%b%b%b | Y=%h | Cout=%b",
                             test_count, A, B, K2, K1, K0, Y, Cout);
                end
            end
        end

        $fclose(vec_file);

        $display("==============================================");
        $display("Regression complete.");
        $display("Total tests : %0d", test_count);
        $display("Failed tests: %0d", fail_count);

        if (fail_count == 0)
            $display("RESULT: PASS");
        else
            $display("RESULT: FAIL");

        $display("==============================================");

        $finish;
    end

endmodule