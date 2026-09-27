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
    mem[8'h01] = 8'h01; // ADD opcode (1)
    mem[8'h02] = 8'h03; // operand = 3

    // --- LOOP START (Address 0x03) ---
    // 2. sub 1
    mem[8'h03] = 8'h02; // SUB opcode (2)
    mem[8'h04] = 8'h01; // operand = 1

    // 3. jnz to address 0x03
    mem[8'h05] = 8'h0F; // JNZ opcode (15 / hex 0F)
    mem[8'h06] = 8'h03; // target address = 0x03 (loops back to SUB)
    // --- LOOP END ---

    // 4. out to address 5 (runs when accumulator hits 0)
    mem[8'h07] = 8'h05; // OUT opcode (5)
    mem[8'h08] = 8'h05; // target RAM address = 5

    // 5. clean
    mem[8'h09] = 8'h06; // CLEAN opcode (6)
    mem[8'h0A] = 8'h00; // operand = 0
end

always @(*) begin
    instruction_byte = mem[address];
end
    
endmodule