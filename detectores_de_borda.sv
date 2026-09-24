// ============================================================
// detector_borda.sv
//
// Sem clk do sistema -- so recebe rst, fsmoutdetin e ps2_data,
// igual o diagrama do professor pede (o clk so entra no Shift
// Register).
//
// Por isso esse bloco eh clocado pelo PROPRIO fsmoutdetin (ps2_clk
// ja filtrado pela FSM), do mesmo jeito que a FSM eh clocada pelo
// ps2_clk. O protocolo PS2 garante que ps2_data fica estavel na
// borda de descida do clock, entao usamos negedge pra amostrar.
//
// Vai acumulando 1 bit a cada borda, e quando fecha o byte (8 bits)
// entrega o scan code pronto:
//
//   data_ready : sobe pra 1 quando o byte fecha, e fica em 1 ate
//                o primeiro bit do PROXIMO byte comecar a chegar
//                (nao ha clock nesse trecho pra "descer" antes disso)
//   novo_dado   : scan code completo (8 bits), valido junto com
//                a subida de data_ready
//
// IMPORTANTE: como esse bloco nao tem clk do sistema, data_ready e
// novo_dado estao no dominio assincrono do ps2_clk. Quem for usar
// isso no Shift Register precisa sincronizar com o clk do sistema
// (2-3 flip-flops) e detectar a BORDA DE SUBIDA de data_ready ali,
// antes de disparar o deslocamento dos displays.
//
// FILTRO DE BREAK CODE: quando o byte completo eh 0xF0 (prefixo que
// o PS2 manda ao SOLTAR uma tecla, antes de repetir o scan code),
// data_ready NAO sobe. Assim esse byte nunca chega no Shift Register
// e nao aparece duplicado/errado no display.
// ============================================================

module detector_borda (
    input  logic rst,          // reset assincrono, ativo em 1
    input  logic fsmoutdetin,  // ps2_clk filtrado, vindo da FSM
    input  logic ps2_data,     // dado bruto do PS2

    output logic       data_ready, // sobe quando o byte fecha
    output logic [7:0] novo_dado    // scan code completo
);

    logic [7:0] byte_acc; // vai juntando os bits recebidos
    logic [2:0] bit_cnt;  // conta 0 a 7

    // clocado pelo proprio fsmoutdetin -- cada negedge eh um bit novo
    always_ff @(negedge fsmoutdetin or posedge rst) begin
        if (rst) begin
            byte_acc   <= 8'd0;
            bit_cnt    <= 3'd0;
            data_ready <= 1'b0;
            novo_dado   <= 8'd0;
        end else begin
            // entra 1 bit por vez, LSB primeiro (padrao PS2)
            byte_acc <= {ps2_data, byte_acc[7:1]};

            if (bit_cnt == 3'd7) begin
                // esse era o ultimo bit -> byte completo
                novo_dado <= {ps2_data, byte_acc[7:1]};

                // 0xF0 eh o "break code" do PS2: o teclado manda esse
                // byte antes de repetir o scan code quando voce SOLTA
                // uma tecla. Desconsideramos ele aqui -- nao levanta
                // data_ready pra ele, entao ele nunca chega no Shift
                // Register (o scan code que vem logo depois do F0
                // continua passando normal)
                data_ready <= ({ps2_data, byte_acc[7:1]} != 8'hF0);
                bit_cnt    <= 3'd0;
            end else begin
                data_ready <= 1'b0; // so fica 1 durante o "descanso" entre bytes
                bit_cnt    <= bit_cnt + 1'b1;
            end
        end
    end

endmodule