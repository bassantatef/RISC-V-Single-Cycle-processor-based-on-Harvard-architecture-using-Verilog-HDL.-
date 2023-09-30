module PC_reg(
    input wire               clk    ,
    input wire               rst    ,
    input wire  [31:0]       PCNext ,
    output reg  [31:0]       PC
);

always @(posedge clk or negedge rst)
begin
    if(!rst)
    begin
        PC <= 32'b0 ;
    end
    else
    begin
        PC <= PCNext ;
    end
end

endmodule