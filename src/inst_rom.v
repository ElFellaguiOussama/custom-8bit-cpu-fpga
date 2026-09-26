module inst_rom (
    input wire [3:0] address ,
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
    mem[8'h01] = 8'h06; // CLEAN
    mem[8'h02] = 8'h00; 
    mem[8'h03] = 8'h01; // ADD
    mem[8'h04] = 8'h01; // num = 1
    mem[8'h05] = 8'h05; // OUT
    mem[8'h06] = 8'h00;
    mem[8'h07] = 8'h03; // SHIFT_LEFT
    mem[8'h08] = 8'h01; // num = 1
    mem[8'h09] = 8'h05; // OUT
    mem[8'h0A] = 8'h00;
    mem[8'd11] = 8'd7; // JUMP TO
    mem[8'd12] = 8'd7; // address 7
end

always @(*) begin
    instruction_byte = mem[address];
end
    
endmodule