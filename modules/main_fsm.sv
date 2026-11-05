
// main finite state maschine for control states of processor (Mealy)
module main_fsm (
    input              clk,
    input              rst,
    input              switch_signal,
    output logic [1:0] current_state
);

    typedef enum bit [3:0]
    {
        S0         = 4'b0000, // start state
        Enter_nums = 4'b0001, // entering numbers state
        Save_nums  = 4'b0010, // saving numbers state
        Sorting    = 4'b0011  // sorting state
    }
    states;

    states state_cur, next_state;

    always_ff @ (posedge clk or posedge rst)
        if (rst)
            state_cur <= S0;
        else if (switch_signal)
            state_cur <= next_state;

    always_comb begin
        next_state = state_cur;
        if (~rst & switch_signal)
            case (state_cur)
                S0:         next_state = Enter_nums;
                Enter_nums: next_state = Save_nums;
                Save_nums:  next_state = Sorting;
                default:    next_state = state_cur;
            endcase
    end

    assign current_state = state_cur;

endmodule
