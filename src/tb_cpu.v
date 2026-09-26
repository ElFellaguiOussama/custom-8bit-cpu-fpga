`timescale 1ns/1ps

module tb_cpu();

reg clk;
wire [3:0] address;
wire [7:0] result;
wire [7:0] instruction_byte;
wire [3:0] op;
wire [7:0] num;
reg start_enable;
wire we;
wire [7:0] counter;

accumulator uua(
    .clk(clk),
    .op(op),
    .num(num),
    .result(result),
    .we(we)
);

inst_rom uub(
    .address(address),
    .instruction_byte(instruction_byte)
);

prog_cntr uuc(
    .clk(clk),
    .address(address),
    .op_code(op),
    .operand(num),
    .instruction_byte(instruction_byte),
    .start_enable(start_enable),
    .we(we),
    .counter(counter)
);

always #70 clk = ~clk;

initial begin
    clk = 0;
    start_enable = 0;
    #100
    start_enable = 1;
    @(posedge clk);
    wait (counter == 30);
    $finish;
end

initial begin
    $dumpfile("tb_cpu.vcd");
    $dumpvars(0,tb_cpu);
end
endmodule