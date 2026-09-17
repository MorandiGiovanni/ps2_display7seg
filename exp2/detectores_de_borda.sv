module detectores_de_borda (
    input logic clk,
    input logic reset,

    input logic incr_a,
    input logic decr_a,
    input logic incr_b,
    input logic decr_b,

    output logic borda_incr_a,
    output logic borda_decr_a,
    output logic borda_incr_b,
    output logic borda_decr_b

);

    edge_detector detector_incr_a (
        .clk      (clk),
        .rst      (reset),
        .data     (incr_a),
        .edge_out (borda_incr_a)
    );

    edge_detector detector_decr_a (
        .clk      (clk),
        .rst      (reset),
        .data     (decr_a),
        .edge_out (borda_decr_a)
    );

    edge_detector detector_incr_b (
        .clk      (clk),
        .rst      (reset),
        .data     (incr_b),
        .edge_out (borda_incr_b)
    );

    edge_detector detector_decr_b (
        .clk      (clk),
        .rst      (reset),
        .data     (decr_b),
        .edge_out (borda_decr_b)
    );

endmodule