
// module which input in_sign and ouput out_strobe (1 takt) when posedge of in_sign
module strobe_sign (
    input        clk,
    input        enb,
    input        in_sign,
    output logic out_strobe
);

    logic prev_in_sign;
    logic cur_in_sign;
	 
    assign cur_in_sign = in_sign;

    always_ff @ (posedge clk)
        if (enb)
            prev_in_sign <= in_sign;

    assign out_strobe = ~prev_in_sign & cur_in_sign;

endmodule
