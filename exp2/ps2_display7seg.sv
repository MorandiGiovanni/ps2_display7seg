module ps2_display7seg (
    input logic clk,
    input logic rst,
    input logic ps2_clk,
    input logic ps2_data,

    output logic[7:0] display, //?? 7 seg
    output logic[7:0] display_en
);

    //variáveis internas
    logic clock_div;
    logic [2:0] saida_contador;

    logic borda_incr_a;
    logic borda_decr_a;
    logic borda_incr_b;
    logic borda_decr_b;


    divisor_clock div_clk (
        .clk_in   (clk),
        .clk_out   (clock_div)
    );

    modulo_contador cont(
        .clock     (clock_div),
        .cont_out (saida_contador)
    );

    decoder dec (
        .contador (saida_contador),
        .display_en (display_en)
    );

    mux_decoder mux (
        .contador (saida_contador),
        ///
        ///
        .display (display)
    );

    detectores_de_borda detectores (
        .clk(clock),
        .reset(reset),

        .incr_a(incr_a),
        .decr_a(decr_a),
        .incr_b(incr_b),
        .decr_b(decr_b),

        .borda_incr_a(borda_incr_a),
        .borda_decr_a(borda_decr_a),
        .borda_incr_b(borda_incr_b),
        .borda_decr_b(borda_decr_b)
    );



endmodule
