module mux_decoder (
    input logic [2:0] contador,

    input logic [3:0] unidade_A,
    input logic [3:0] dezena_A,
    input logic [3:0] centena_A,
    input logic [3:0] milhar_A,
    input logic [3:0] unidade_B,
    input logic [3:0] dezena_B,
    input logic [3:0] centena_B,
    input logic [3:0] milhar_B,

    output logic [6:0] display 
);

    logic [3:0] valor;

    //seleciona o dado correto com base no contador
    always_comb begin
        case (contador)
            3'b000: valor = unidade_A;
            3'b001: valor = dezena_A;
            3'b010: valor = centena_A;
            3'b011: valor = milhar_A;
            3'b100: valor = unidade_B;
            3'b101: valor = dezena_B;
            3'b110: valor = centena_B;
            3'b111: valor = milhar_B;
            default: valor = 4'b0000;
        endcase
    end
    
    //decodifica o valor selecionado para o display de 7 segmentos
    always_comb begin
        case (valor)
            4'd0: display = 7'b0000001;
            4'd1: display = 7'b1001111;
            4'd2: display = 7'b0010010;
            4'd3: display = 7'b0000110;
            4'd4: display = 7'b1001100;
            4'd5: display = 7'b0100100;
            4'd6: display = 7'b0100000;
            4'd7: display = 7'b0001111;
            4'd8: display = 7'b0000000;
            4'd9: display = 7'b0000100;
        default: display = 7'b1111111;
        endcase
    end
endmodule