module accumulator(
    input wire clk,
    input wire [3:0] op,
    input wire [7:0] num,
    output reg [7:0] result = 0,
    input wire we,
    output reg [7:0] address_mem = 0,
    output wire zero_flag,
    output reg we_ram
);

reg [7:0] data = 8'd0 ;

localparam ADD = 4'd1 ;
localparam SUB = 4'd2;
localparam SHIFT_LEFT = 4'd3;
localparam SHIFT_RIGHT = 4'd4;
localparam OUT = 4'd5;
localparam CLEAN = 4'd6;
localparam AND = 4'd7;
localparam OR = 4'd8;
localparam NOT = 4'd9;

assign zero_flag = (result == 0);

always @(posedge clk ) begin
    we_ram <= 0;
    if (op != 0 && we) begin
        case (op)
            ADD : begin
                data <= data + num;
            end
            SUB : begin
                data <= data - num;
            end
            SHIFT_LEFT : begin
                data <= data << (num & 8'h7);
            end
            SHIFT_RIGHT : begin
                data <= data >> (num & 8'h7);
            end
            AND : begin
                data <= data & num;
            end
            OR : begin
                data <= data | num;
            end
            NOT : begin
                data <= ~num;
            end
            OUT : begin
                result <= data;
                address_mem <= num;
                we_ram <= 1;
            end
            CLEAN : begin
                result <= 8'd0;
                data <= 8'd0;
            end 
            default: begin
                data <= data;
            end
        endcase
    end
    else begin
        result <= result;
    end
end
endmodule