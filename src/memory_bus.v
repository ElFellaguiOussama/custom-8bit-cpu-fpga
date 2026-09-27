module memory_bus(
    input wire clk,
    input wire [7:0] address_mem,
    input wire [7:0] data_in,
    input wire we,
    output wire [7:0] d_out,
    output reg [7:0] led_reg = 0
);

wire [7:0] d_out_ram;
wire is_io = (address_mem == 8'hFF);
wire actual_ram_we = (we & ~is_io);
wire io_we = (we & is_io);

ram ram_mod(
    .clk(clk),
    .we(actual_ram_we),
    .addr(address_mem),
    .d_in(data_in),
    .d_out(d_out_ram)
);

assign d_out = is_io ? led_reg : d_out_ram; 


always @(posedge clk) begin
    if(io_we)
    begin
        led_reg <= data_in;
    end
end
endmodule