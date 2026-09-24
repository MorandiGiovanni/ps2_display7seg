module mux_decoder (
    input  logic [2:0] contador,

    input  logic [7:0] AN_pos0,
    input  logic [7:0] AN_pos1,
    input  logic [7:0] AN_pos2,
    input  logic [7:0] AN_pos3,
    input  logic [7:0] AN_pos4,
    input  logic [7:0] AN_pos5,
    input  logic [7:0] AN_pos6,
    input  logic [7:0] AN_pos7,

    output logic [7:0] display // Saída dos segmentos
);

    logic [7:0] valor;

    // Seleciona o scancode da posição atual
    always_comb begin
        case (contador)
            3'b000: valor = AN_pos0;
            3'b001: valor = AN_pos1;
            3'b010: valor = AN_pos2;
            3'b011: valor = AN_pos3;
            3'b100: valor = AN_pos4;
            3'b101: valor = AN_pos5;
            3'b110: valor = AN_pos6;
            3'b111: valor = AN_pos7;
            default: valor = 8'h00;
        endcase
    end

    // Decodifica para Display de 7 segmentos 
    always_comb begin
        case (valor)
            //NÚMEROS
            8'h45: display = 8'b1100_0000; // '0'
            8'h16: display = 8'b1111_1001; // '1'
            8'h1E: display = 8'b1010_0100; // '2'
            8'h26: display = 8'b1011_0000; // '3'
            8'h25: display = 8'b1001_1001; // '4'
            8'h2E: display = 8'b1001_0010; // '5'
            8'h36: display = 8'b1000_0010; // '6'
            8'h3D: display = 8'b1111_1000; // '7'
            8'h3E: display = 8'b1000_0000; // '8'
            8'h46: display = 8'b1001_0000; // '9'

            //LETRAS
            8'h1C: display = 8'b1000_1000; // 'A'
            8'h32: display = 8'b1000_0011; // 'b'
            8'h21: display = 8'b1100_0110; // 'C'
            8'h23: display = 8'b1010_0001; // 'd'
            8'h24: display = 8'b1000_0110; // 'E'
            8'h2B: display = 8'b1000_1110; // 'F'
            8'h34: display = 8'b1001_0000; // 'G'
            8'h33: display = 8'b1000_1011; // 'h'
            8'h43: display = 8'b1111_1001; // 'I'
            8'h3B: display = 8'b1110_0001; // 'J'
            8'h42: display = 8'b1000_1010; // 'K'
            8'h4B: display = 8'b1100_0111; // 'L'
            8'h3A: display = 8'b1100_1000; // 'M'
            8'h31: display = 8'b1010_1011; // 'n'
            8'h44: display = 8'b1100_0000; // 'O'
            8'h4D: display = 8'b1000_1100; // 'P'
            8'h15: display = 8'b1001_1000; // 'Q'
            8'h2D: display = 8'b1010_1111; // 'r'
            8'h1B: display = 8'b1001_0010; // 'S'
            8'h2C: display = 8'b1000_0111; // 't'
            8'h3C: display = 8'b1100_0001; // 'U'
            8'h2A: display = 8'b1110_0011; // 'v'
            8'h1D: display = 8'b1100_0001; // 'W'
            8'h22: display = 8'b1000_1001; // 'X'
            8'h35: display = 8'b1001_0001; // 'Y'
            8'h1A: display = 8'b1010_0100; // 'Z'

            default: display = 8'b1111_1111; // Apagado, reset
        endcase
    end

endmodule