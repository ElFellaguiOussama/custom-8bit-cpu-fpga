module prog_cntr(
    input wire clk,
    input wire [7:0] instruction_byte,
    output reg [3:0] address = 1,
    output reg [3:0] op_code = 0,
    output reg [7:0] operand,
    input wire start_enable,
    output reg we = 0,
    output reg [7:0] counter = 0,
    output reg [7:0] rom_address = 0,
    input wire [7:0] rom_data_in
);

reg [7:0] op ;
reg [7:0] num ;
reg [7:0] rom_data ;

localparam inst_1 = 0 ;
localparam inst_2 = 1 ;
localparam exe = 2 ;
localparam mem_wait = 3;
localparam mem_exec = 4;

localparam ADD = 8'd1 ;
localparam SUB = 8'd2;
localparam SHIFT_LEFT = 8'd3;
localparam SHIFT_RIGHT = 8'd4;
localparam OUT = 8'd5;
localparam CLEAN = 8'd6;
localparam JUMP = 8'd7;
localparam ADD_MEM = 8'd8;
localparam SUB_MEM = 8'd9;
localparam SHIFT_LEFT_MEM = 8'd10;
localparam SHIFT_RIGHT_MEM = 8'd11;

reg [2:0] state = 2'd0 ;


always @(posedge clk ) begin
    if(start_enable)begin
        case (state)
            inst_1 : begin
                op <= instruction_byte;
                state <= inst_2;
                address <= address + 8'd1;
                we <= 0;         
            end
            inst_2 : begin
                num <= instruction_byte;
                state <= exe;
            end
            exe : begin
                counter <= counter + 8'd1;
                if(op <= 8'd6) begin
                    op_code <= (op & 4'hF);
                    operand <= num;
                    address <= address + 8'd1;
                    state <= inst_1;
                    num <= 0;
                    op <= 0;
                    we <= 1;
                end
                else if(op >= 8'd7) begin
                    case (op)
                        ADD_MEM : begin
                            state <= mem_wait;
                            rom_address <= num;
                            op <= ADD;
                        end
                        SUB_MEM : begin
                            state <= mem_wait;
                            rom_address <= num;
                            op <= SUB;
                        end
                        SHIFT_LEFT_MEM : begin
                            state <= mem_wait;
                            rom_address <= num;
                            op <= SHIFT_LEFT;
                        end
                        SHIFT_RIGHT_MEM : begin
                            state <= mem_wait;
                            rom_address <= num;
                            op <= SHIFT_RIGHT;
                        end
                        JUMP : begin
                            address <= num;
                            state <= inst_1;
                            num <= 0;
                            op <= 0;
                        end
                        default: begin 
                            state <= inst_1;
                        end
                    endcase
                end
            end
            mem_wait : begin
                state <= mem_exec;
                num <= rom_data_in;
            end
            mem_exec : begin
                state <= inst_1;
                operand <= num;
                op_code <= op;
                address <= address + 8'd1;
                num <= 0;
                op <= 0;
                we <= 1;
            end  
            default: begin 
                state <= inst_1;
                op_code <= 0;
                operand <= 0;
            end
        endcase
    end
end
endmodule