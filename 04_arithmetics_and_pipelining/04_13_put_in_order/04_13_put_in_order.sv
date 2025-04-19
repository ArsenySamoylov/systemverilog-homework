module put_in_order
# (
    parameter width    = 16,
              n_inputs = 4
)
(
    input                       clk,
    input                       rst,

    input  [ n_inputs - 1 : 0 ] up_vlds,
    input  [ n_inputs - 1 : 0 ]
           [ width    - 1 : 0 ] up_data,

    output logic              down_vld,
    output logic [ width - 1 : 0 ] down_data
);

    // Task:
    //
    // Implement a module that accepts many outputs of the computational blocks
    // and outputs them one by one in order. Input signals "up_vlds" and "up_data"
    // are coming from an array of non-pipelined computational blocks.
    // These external computational blocks have a variable latency.
    //
    // The order of incoming "up_vlds" is not determent, and the task is to
    // output "down_vld" and corresponding data in a round-robin manner,
    // one after another, in order.
    //
    // Comment:
    // The idea of the block is kinda similar to the "parallel_to_serial" block
    // from Homework 2, but here block should also preserve the output order.
    logic [clog2(n_inputs) - 1 : 0] current_index;
    logic [n_inputs - 1 : 0] valid_indices;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            down_vld <= 1'b0;
            down_data <= {width{1'b0}};
            current_index <= 0;
        end else begin
            valid_indices = up_vlds;

            if (valid_indices != 0) begin
                for (int i = 0; i < n_inputs; i++) begin
                    int idx = (current_index + i) % n_inputs;

                    if (valid_indices[idx]) begin
                        down_data <= up_data[idx]; 
                        down_vld <= 1'b1; 

                        current_index <= (idx + 1) % n_inputs; 
                        break; 
                    end
                end
            end else begin
                down_vld <= 1'b0; 
            end
        end
    end

endmodule
