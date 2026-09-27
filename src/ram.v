module ram(
    input wire clk,
    input wire we,
    input wire [7:0] addr,
    input wire [7:0] d_in,
    output reg [7:0] d_out = 0
);

reg [7:0] mem [0:255];

integer i;

initial begin
    for(i=0 ; i<256 ; i=i+1)
        mem[i] = 8'd00;
end


always @(posedge clk ) begin
    
    if(addr != 0)
    begin
        d_out <= mem[addr];
        if (we) begin
            mem[addr] <= d_in;
        end
    end    
    else begin
        d_out <= 0;
    end
    

end
endmodule