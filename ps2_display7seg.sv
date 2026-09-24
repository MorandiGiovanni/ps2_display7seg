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

    logic data_ready;
    logic [7:0] data_out;
    
    logic fsm_out;
    logic [7:0] AN_pos0,
    logic [7:0] AN_pos1,
    logic [7:0] AN_pos2,
    logic [7:0] AN_pos3,
    logic [7:0] AN_pos4,
    logic [7:0] AN_pos5,
    logic [7:0] AN_pos6,
    logic [7:0] AN_pos7


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

    fsm FSM(
        .reset(rst),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .fsmoutdetin(fsm_out)
    )
    
    detector_de_borda detectores (
        .fsmoutdetin(fsm_out),
        .rst(rst),
        .ps2_data(ps2_data),
        .novo_dado(data_out),
        .data_ready(data_ready)
    );
    
    shift_register sr(
        .reset(rst);
        .clock(clk);
        .AN_novo(data_out);
        .novo_dado(data_ready);
        .AN_pos0(AN_pos0);
        .AN_pos1(AN_pos1);
        .AN_pos2(AN_pos2);
        .AN_pos3(AN_pos3);
        .AN_pos4(AN_pos4);
        .AN_pos5(AN_pos5);
        .AN_pos6(AN_pos6);
        .AN_pos7(AN_pos7);
    );
    
    mux_decoder mux (
        .contador (saida_contador),
        .AN_pos0(AN_pos0);
        .AN_pos1(AN_pos1);
        .AN_pos2(AN_pos2);
        .AN_pos3(AN_pos3);
        .AN_pos4(AN_pos4);
        .AN_pos5(AN_pos5);
        .AN_pos6(AN_pos6);
        .AN_pos7(AN_pos7);
        .display (display)
    );





endmodule
