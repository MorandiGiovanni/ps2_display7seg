module fsm (
    input logic reset,
    input logic ps2_clk,
    input logic ps2_data,

    output logic fsmoutdetin
    );
    
    logic reg_p;
    logic stop,start;
    logic [3:0] cont;


    always_ff @(posedge ps2_clk or posedge reset) begin
        if(reset) begin
        ps2_data <= start;
        cont = '0;
        end
        else if(ps2_clk)
        cont = cont + 1;
        if(cont = 3'b0001)
        fsmoutdetin <= start;
    end


endmodule