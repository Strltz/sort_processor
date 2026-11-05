// top-module

module sort_processor(
    input              clk,
    input              rst,
    input        [3:0] key,
    output logic [3:0] led,
    output logic [7:0] symbol_7seg,
    output logic [3:0] number_7seg
);

    logic       _clk;
    logic       _rst;
    logic [3:0] _key;
    logic [3:0] _led;
    logic [7:0] _symbol_7seg;
    logic [3:0] _number_7seg;
    assign _clk        = ~clk;
    assign _rst        = ~rst;
    assign _key        = ~key;
    assign led         = ~_led;
    assign symbol_7seg = ~_symbol_7seg;
    assign number_7seg = ~_number_7seg;

    logic fsm_out;
	 
    logic strb;
	 
    strobe_sign strobe_key3 (
        .clk        ( _clk),
        .enb        (~_rst),
        .in_sign    ( _key[3]),
        .out_strobe (strb)
    );

    main_fsm states_sort_processor (
        .clk           (_clk),
        .rst           (_rst),
        .switch_signal (strb),
        .current_state (fsm_out)
    );

    assign _led = fsm_out;

endmodule
