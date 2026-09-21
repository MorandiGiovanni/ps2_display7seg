module detectores_de_borda (
    input logic clk,
    input logic reset,

    input logic fsmoutdetin,

    output logic novo_dado
);
    
    fsm para_detector (
        .reset       (reset),
        .ps2_clk     (clk),
        .fsmoutdetin (fsmoutdetin)
    );

    edge_detector detector_fsm (
        .clk      (clk),
        .rst      (reset),
        .data     (fsmoutdetin),
        .edge_out (novo_dado)
    );

endmodule