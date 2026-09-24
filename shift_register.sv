module shift_register (
    input logic [7:0] AN_novo,
    input logic reset,
    input logic clock,
    input novo_dado,

    output  logic [7:0] AN_pos0,
    output  logic [7:0] AN_pos1,
    output  logic [7:0] AN_pos2,
    output  logic [7:0] AN_pos3,
    output  logic [7:0] AN_pos4,
    output  logic [7:0] AN_pos5,
    output  logic [7:0] AN_pos6,
    output  logic [7:0] AN_pos7

    );

    // ------------------------------------------------------------
    // novo_dado e AN_novo vem do Detector de Borda, que nao tem
    // clock nenhum (vive no dominio assincrono do ps2_clk). Aqui
    // sincronizamos os dois com "clock" antes de usar, pra evitar
    // metaestabilidade.
    //
    // novo_dado_ff1/ff2/ff3: 3 estagios porque precisamos comparar
    // o valor "atual" (ff2) com o "anterior" (ff3) pra achar a
    // borda de subida.
    // AN_novo_ff1/ff2: mesmo atraso de 2 estagios do novo_dado,
    // pra ficar alinhado no tempo com ele.
    // ------------------------------------------------------------
    logic novo_dado_ff1, novo_dado_ff2, novo_dado_ff3;
    logic [7:0] AN_novo_ff1, AN_novo_ff2;

    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            novo_dado_ff1 <= 1'b0;
            novo_dado_ff2 <= 1'b0;
            novo_dado_ff3 <= 1'b0;
            AN_novo_ff1   <= 8'b0;
            AN_novo_ff2   <= 8'b0;
        end else begin
            novo_dado_ff1 <= novo_dado;
            novo_dado_ff2 <= novo_dado_ff1;
            novo_dado_ff3 <= novo_dado_ff2; // usado so pra achar a borda

            AN_novo_ff1 <= AN_novo;
            AN_novo_ff2 <= AN_novo_ff1;
        end
    end

    // borda de subida do novo_dado ja sincronizado -> vira um pulso
    // de 1 ciclo, mesmo o sinal original ficando em nivel alto por
    // varios ciclos la na origem
    logic novo_dado_pulse;
    assign novo_dado_pulse = novo_dado_ff2 & ~novo_dado_ff3;

    always_ff@(posedge clock or posedge reset)begin
        if(reset)begin
            AN_pos7<= 8'b1111_1111;
            AN_pos6<= 8'b1111_1111;
            AN_pos5<= 8'b1111_1111;
            AN_pos4<= 8'b1111_1111;
            AN_pos3<= 8'b1111_1111;
            AN_pos2<= 8'b1111_1111;
            AN_pos1<= 8'b1111_1111;
            AN_pos0<= 8'b1111_1111;
        end
        else if (novo_dado_pulse)begin
            AN_pos7<=AN_pos6;
            AN_pos6<=AN_pos5;
            AN_pos5<=AN_pos4;
            AN_pos4<=AN_pos3;
            AN_pos3<=AN_pos2;
            AN_pos2<=AN_pos1;
            AN_pos1<=AN_pos0;
            AN_pos0<=AN_novo_ff2;
        end
    end

endmodule