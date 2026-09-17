module edge_detector (
    input  logic clk,
    input  logic rst,
    input  logic data,      // sinal do botão
    output logic edge_out
);
    logic regA, regB;

    always_ff @(posedge clk) begin
        if (rst) begin
            regA <= 1'b0;
            regB <= 1'b0;
        end else begin
            regB <= regA;
            regA <= data;
        end
    end

    assign edge_out = regA & ~regB;

endmodule
