`timescale 1ns/1ps

module tb_cpu();

reg clk;
wire we_ram;
wire [7:0] address_ram;
wire [7:0] d_out_accu;
wire [7:0] d_out_ram;
wire [3:0] operation;
wire [7:0] operand;
wire we_accu;
wire zero_flag;
wire [7:0] rom_out;
wire [7:0] rom_address;
reg start_enable;
wire [7:0] counter;
wire [7:0] address_ram_from_pc;
wire [7:0] address_ram_from_accu;
wire [7:0] led_reg ;

assign address_ram = we_ram ? address_ram_from_accu : address_ram_from_pc;




/*ram ram_sim(
    .clk(clk),
    .we(we_ram),
    .addr(address_ram),
    .d_in(d_out_accu),
    .d_out(d_out_ram)
);*/

memory_bus mem_bus(
    .clk(clk),
    .address_mem(address_ram),
    .data_in(d_out_accu),
    .we(we_ram),
    .d_out(d_out_ram),
    .led_reg(led_reg)
);

accumulator accu_sim(
    .clk(clk),
    .op(operation),
    .num(operand),
    .result(d_out_accu),
    .we(we_accu),
    .address_mem(address_ram_from_accu),
    .zero_flag(zero_flag),
    .we_ram(we_ram)
);
prog_cntr pc_sim(
    .clk(clk),
    .instruction_byte(rom_out),
    .address(rom_address) ,
    .op_code(operation),
    .operand(operand),
    .start_enable(start_enable),
    .we(we_accu),
    .counter(counter),
    .rom_address(address_ram_from_pc),
    .rom_data_in(d_out_ram),
    .zero_flag(zero_flag)
);
inst_rom inst_rom_sim(
    .address(rom_address) ,
    .instruction_byte(rom_out)
);

always #70 clk = ~clk;

initial begin
    clk = 0;
    start_enable = 0;
    #100
    start_enable = 1;
    #1000000000
    $finish;
end
integer i;
initial begin
    $dumpfile("tb_cpu.vcd");
    $dumpvars(0,tb_cpu);
    for (i = 0; i < 20; i = i + 1) begin
        $dumpvars(0, tb_cpu.mem_bus.ram_mod.mem[i]);
    end
end
endmodule