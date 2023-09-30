module RISCV_top (
    input  wire                 clk ,
    input  wire                 rst        
);

    // internal signals
    wire       [31:0]     instr     ;
    wire       [31:0]     ReadData  ;
    wire       [31:0]     PC        ;
    wire       [31:0]     DataAdr   ;
    wire       [31:0]     WriteData ;
    wire                  MemWrite  ;

processor U0_processor (
    .clk       (clk       ) ,
    .rst       (rst       ) ,
  
    .instr     (instr     ) ,
    .ReadData  (ReadData  ) ,

    .PC        (PC        ) ,
    .DataAdr   (DataAdr   ) ,
    .WriteData (WriteData ) ,
    .MemWrite  (MemWrite  ) 
);

instr_memory U1_instr_memory (
    .address   (PC        ) ,
    .instr     (instr     ) 
);

data_memory U2_data_memory (
    .clk       (clk       ) ,
    .rst       (rst       ) ,
    .WE        (MemWrite  ) ,
    .address   (DataAdr   ) ,
    .WD        (WriteData ) ,
    .RD        (ReadData  ) 
);


endmodule