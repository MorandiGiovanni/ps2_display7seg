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
        else if (novo_dado==1)begin
            AN_pos7<=AN_pos6;
            AN_pos6<=AN_pos5;
            AN_pos5<=AN_pos4;
            AN_pos4<=AN_pos3;
            AN_pos3<=AN_pos2;
            AN_pos2<=AN_pos1;
            AN_pos1<=AN_pos0;
            AN_pos0<=AN_novo;
        end
    end

endmodule