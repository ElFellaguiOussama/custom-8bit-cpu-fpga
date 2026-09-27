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
mem[8'h01] = 8'd1;
mem[8'h02] = 8'd50;
mem[8'h03] = 8'd5;
mem[8'h04] = 8'd1;
mem[8'h05] = 8'd6;
mem[8'h06] = 8'd0;
mem[8'h07] = 8'd1;
mem[8'h08] = 8'd50;
mem[8'h09] = 8'd5;
mem[8'h0A] = 8'd2;
mem[8'h0B] = 8'd6;
mem[8'h0C] = 8'd0;
mem[8'h0D] = 8'd1;
mem[8'h0E] = 8'd50;
mem[8'h0F] = 8'd5;
mem[8'h10] = 8'd3;
mem[8'h11] = 8'd6;
mem[8'h12] = 8'd0;
mem[8'h13] = 8'd1;
mem[8'h14] = 8'd1;
mem[8'h15] = 8'd5;
mem[8'h16] = 8'd255;
mem[8'h17] = 8'd6;
mem[8'h18] = 8'd0;
mem[8'h19] = 8'd6;
mem[8'h1A] = 8'd0;
mem[8'h1B] = 8'd11;
mem[8'h1C] = 8'd3;
mem[8'h1D] = 8'd2;
mem[8'h1E] = 8'd1;
mem[8'h1F] = 8'd5;
mem[8'h20] = 8'd3;
mem[8'h21] = 8'd15;
mem[8'h22] = 8'd25;
mem[8'h23] = 8'd6;
mem[8'h24] = 8'd0;
mem[8'h25] = 8'd1;
mem[8'h26] = 8'd50;
mem[8'h27] = 8'd5;
mem[8'h28] = 8'd3;
mem[8'h29] = 8'd6;
mem[8'h2A] = 8'd0;
mem[8'h2B] = 8'd11;
mem[8'h2C] = 8'd2;
mem[8'h2D] = 8'd2;
mem[8'h2E] = 8'd1;
mem[8'h2F] = 8'd5;
mem[8'h30] = 8'd2;
mem[8'h31] = 8'd15;
mem[8'h32] = 8'd25;
mem[8'h33] = 8'd6;
mem[8'h34] = 8'd0;
mem[8'h35] = 8'd1;
mem[8'h36] = 8'd50;
mem[8'h37] = 8'd5;
mem[8'h38] = 8'd2;
mem[8'h39] = 8'd6;
mem[8'h3A] = 8'd0;
mem[8'h3B] = 8'd11;
mem[8'h3C] = 8'd1;
mem[8'h3D] = 8'd2;
mem[8'h3E] = 8'd1;
mem[8'h3F] = 8'd5;
mem[8'h40] = 8'd1;
mem[8'h41] = 8'd15;
mem[8'h42] = 8'd25;
mem[8'h43] = 8'd6;
mem[8'h44] = 8'd0;
mem[8'h45] = 8'd1;
mem[8'h46] = 8'd50;
mem[8'h47] = 8'd5;
mem[8'h48] = 8'd1;
mem[8'h49] = 8'd6;
mem[8'h4A] = 8'd0;
mem[8'h4B] = 8'd11;
mem[8'h4C] = 8'd255;
mem[8'h4D] = 8'd3;
mem[8'h4E] = 8'd1;
mem[8'h4F] = 8'd5;
mem[8'h50] = 8'd255;
mem[8'h51] = 8'd15;
mem[8'h52] = 8'd25;
mem[8'h53] = 8'd16;
mem[8'h54] = 8'd17;
end

always @(*) begin
    instruction_byte = mem[address];
end
    
endmodule