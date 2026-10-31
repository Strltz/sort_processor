
// resgisters module (16 4-bit registers)
module registers_RON (
    input              mode_r_w, // 0 - read, 1 - write
    input              enb,
    input              clr,
    input        [3:0] in_data,
    input        [3:0] address,
    output logic [3:0] out_data
);

    logic [15:0] registers [3:0];

    always_ff @ (posedge enb or posedge clr) begin
        if (clr) begin
            out_data <= 4'b0000;
            for (int i = 0; i < 16; i = i + 1)
                registers[i] <= 4'b0000;
        end else if (enb)
            if (mode_r_w == 0)
                out_data <= registers[address];
            else begin
                out_data           <= 4'b0000;
                registers[address] <= in_data;
            end
    end

endmodule