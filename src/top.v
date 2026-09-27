module cpu_top (
    input wire clk1,
    //input wire start_enable,
    output wire [5:0] led_reg 
);

Gowin_CLKDIV clkdiv(
    .clkout(clk),
    .hclkin(clk1),
    .resetn(1'b1)
);

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

wire [7:0] counter;
wire [7:0] address_ram_from_pc;
wire [7:0] address_ram_from_accu;
wire [7:0] led_reg_ram;

assign led_reg = ~led_reg_ram;


assign address_ram = we_ram ? address_ram_from_accu : address_ram_from_pc;

memory_bus mem_bus(
    .clk(clk),
    .address_mem(address_ram),
    .data_in(d_out_accu),
    .we(we_ram),
    .d_out(d_out_ram),
    .led_reg(led_reg_ram)
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
    .start_enable(1'b1),
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



endmodule