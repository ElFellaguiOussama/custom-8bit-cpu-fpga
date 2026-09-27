module inst_rom (
    input wire [7:0] address ,
    output reg [7:0] instruction_byte = 0
);

reg [7:0] mem [0:255];
        integer i;
initial begin

    for (i = 0 ; i < 256 ; i = i+1 ) begin
        mem[i] = 0;
    end
end
initial begin
// 1. add 3
    mem[8'h01] = 8'd1;
    mem[8'h02] = 8'b00110101;

    mem[8'h03] = 8'd5;
    mem[8'h04] = 8'hFF;

    mem[8'h05] = 8'd6;
    mem[8'h06] = 8'd0;

    mem[8'h07] = 8'd11;
    mem[8'h08] = 8'hff;

    mem[8'h09] = 8'd3;
    mem[8'h0A] = 8'd1;
    mem[8'h0B] = 8'd5;
    mem[8'h0C] = 8'hff;
    mem[8'h0D] = 8'd15;
    mem[8'h0E] = 8'd5;
    /*mem[8'h0F] = 8'd15;
    mem[8'h10] = 8'd7;*/
end

always @(*) begin
    instruction_byte = mem[address];
end
    
endmodule