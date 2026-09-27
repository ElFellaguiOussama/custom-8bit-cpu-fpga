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
// 1. add 1
    mem[8'h01] = 8'h01; // ADD opcode
    mem[8'h02] = 8'h01; // operand = 1

    // 2. out to address 1
    mem[8'h03] = 8'h05; // OUT opcode
    mem[8'h04] = 8'h01; // address = 1

    // 3. clean
    mem[8'h05] = 8'h06; // CLEAN opcode
    mem[8'h06] = 8'h00; // operand = 0

    // 4. add 10
    mem[8'h07] = 8'h01; // ADD opcode
    mem[8'h08] = 8'h0A; // operand = 10 (hex 0A)

    // 5. out to address 2
    mem[8'h09] = 8'h05; // OUT opcode
    mem[8'h0A] = 8'h02; // address = 2

    // 6. clean
    mem[8'h0B] = 8'h06; // CLEAN opcode
    mem[8'h0C] = 8'h00; // operand = 0

    // 7. add address 1
    mem[8'h0D] = 8'h0B; // ADD_MEM opcode (11)
    mem[8'h0E] = 8'h01; // source address = 1

    // 8. add address 2
    mem[8'h0F] = 8'h0B; // ADD_MEM opcode (11)
    mem[8'h10] = 8'h02; // source address = 2

    // 9. out to address 3
    mem[8'h11] = 8'h05; // OUT opcode
    mem[8'h12] = 8'h03; // address = 3

    // 10. clean
    mem[8'h13] = 8'h06; // CLEAN opcode
    mem[8'h14] = 8'h00; // operand = 0
end

always @(*) begin
    instruction_byte = mem[address];
end
    
endmodule