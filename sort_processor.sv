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
	 
	 assign _led = _key;
	 

    show_bin_7seg (
        .clk         (_clk),
        .rst         (_rst),
        .enb         (1'b1),
		  .data        (_key),
        .symbol_7seg (_symbol_7seg),
        .number_7seg (_number_7seg)
    );

endmodule
