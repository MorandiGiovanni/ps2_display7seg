module fsm (
    input logic reset,
    input logic ps2_clk,
    input logic ps2_data,

    output logic fsmoutdetin
    );
    
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        P,
        STOP
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_cnt;



    always_ff @(negedge ps2_clk or posedge reset) begin
        
        if(reset)begin
            state <= IDLE;
            bit_cnt <= 3'b0;
        end
        else begin 
            state <= next_state;
            if(state == DATA)
                bit_cnt <= bit_cnt + 1'b1;
            else if(state == IDLE)
                bit_cnt <= 3'd0;
        end
    end


    always_comb begin
    next_state = state;
        case (state)
            IDLE:    next_state = (ps2_data == 1'b0) ? START : IDLE;
            START:   next_state = DATA;
            DATA:    next_state = (bit_cnt == 3'd7) ? P : DATA;
            P:       next_state = STOP;
            STOP:    next_state = START;
            default: next_state = IDLE;
        endcase
    end

    assign fsmoutdetin = (state == DATA) ? ps2_clk : 1'b1;
    
endmodule