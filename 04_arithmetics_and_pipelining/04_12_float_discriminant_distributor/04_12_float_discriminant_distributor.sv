module float_discriminant_distributor (
    input                           clk,
    input                           rst,

    input                           arg_vld,
    input        [FLEN - 1:0]       a,
    input        [FLEN - 1:0]       b,
    input        [FLEN - 1:0]       c,

    output logic                    res_vld,
    output logic [FLEN - 1:0]       res,
    output logic                    res_negative,
    output logic                    err,

    output logic                    busy
);

    // Task:
    //
    // Implement a module that will calculate the discriminant based
    // on the triplet of input number a, b, c. The module must be pipelined.
    // It should be able to accept a new triple of arguments on each clock cycle
    // and also, after some time, provide the result on each clock cycle.
    // The idea of the task is similar to the task 04_11. The main difference is
    // in the underlying module 03_08 instead of formula modules.
    //
    // Note 1:
    // Reuse your file "03_08_float_discriminant.sv" from the Homework 03.
    //
    // Note 2:
    // Latency of the module "float_discriminant" should be clarified from the waveform.
    localparam N = 9;
    
    logic [31:0] in_a   [N];
    logic [31:0] in_b   [N];
    logic [31:0] in_c   [N];
    logic        in_vld [N];

    logic        out_vld [N];
    logic [31:0] out_res [N];
    logic        out_res_neg  [N];
    logic        out_err      [N];

    logic out_busy [N];

    logic [5:0] cnt;

    always_ff @ (posedge clk) begin
        if (rst) begin
            cnt <= '0;
        end

        if(cnt ==  N - 1)
            cnt <= 0;
        else
            cnt++;
    end
    
    always_comb begin
        for (int i = 0; i < N; i++)
            in_vld[i] = '0;

        in_a  [cnt] = a;
        in_b  [cnt] = b;
        in_c  [cnt] = c;
        in_vld[cnt] = arg_vld;   

        res_vld      = out_vld[cnt];
        res          = out_res[cnt];
        res_negative = out_res_neg[cnt];
        err          = out_err[cnt];

        busy = out_busy[cnt];
    end


    generate
        genvar i;
        for (i = 0; i < N; i++)
            float_discriminant f1(
                .clk(clk),
                .rst(rst),

                .arg_vld(in_vld[i]),
                .a(in_a[i]),
                .b(in_b[i]),
                .c(in_c[i]),
                
                .res_vld(out_vld[i]),
                .res    (out_res[i]),
                .res_negative(out_res_neg[i]),
                .err    (out_err[i]),
                
                .busy(out_busy[i]));
    endgenerate

endmodule
