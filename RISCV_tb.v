module RISCV_tb ();

reg                 clk_tb    ;
reg                 rst_tb    ;       


initial begin
    clk_tb = 1'b0 ;
    rst_tb = 1'b1 ;
    #5
    rst_tb = 1'b0 ;
    #5
    rst_tb = 1'b1 ;

    // addi x6,  x0,  B       00B00313       --> I-Type

    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'h6 & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'hB) begin
            $display("PASSED : addi instruction");
        end 
        else begin
            $display("FAILED : addi instruction");
        end 
    end 
    
    #10

    // addi x7,  x0,  5       00500393       --> I-Type

    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'h7 & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h5) begin
            $display("PASSED : addi instruction 2 ");
        end 
        else begin
            $display("FAILED : : addi instruction 2");
        end 
    end 
    
    #10

    // addi x8,  x0,  3       00300413       --> I-Type

    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'h8 & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h3) begin
            $display("PASSED : addi instruction 3");
        end 
        else begin
            $display("FAILED : addi instruction 3");
        end 
    end 
    
    #10

    // or   x9,  x6,  x8     008364B3   --> R-Type
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'h9 & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'hB) begin
            $display("PASSED : or instruction");
        end 
        else begin
            $display("FAILED : or instruction");
        end 
    end 

    #10

    // and  x10, x7,  x8     0083F533   --> R-Type
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hA & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h1) begin
            $display("PASSED : and instruction");
        end 
        else begin
            $display("FAILED : and instruction");
        end 
    end 

    #10

    // add  x11, x10, x9     009505B3   --> R-Type
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hB & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'hC) begin
            $display("PASSED : add instruction");
        end 
        else begin
            $display("FAILED : add instruction");
        end 
    end 

    #10

    // beq  x8,  x7,  L2       02740263   --> B-Type
    // will not branch
    if(DUT.U0_processor.U0_control_unit.PCSrc == 0 && DUT.U0_processor.U0_control_unit.Branch) begin
        $display("PASSED : branch instruction 1");
    end
    else begin
        $display("FAILED : branch instruction 1");
    end 

    #10

    // slt  x12, x9,  x11     00B4A633   --> R-Type
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hC & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h1) begin
            $display ("PASSED : slt instruction");
        end 
        else begin
            $display("FAILED : slt instruction");
        end 
    end 

    #10
    
    // beq  x10, x12, L1       00C50463   --> B-Type
    // will  branch
    if(DUT.U0_processor.U0_control_unit.PCSrc && DUT.U0_processor.U0_control_unit.Branch) begin
        $display("PASSED : branch instruction 2");
    end
    else begin
        $display("FAILED : branch instruction 2");
    end 

    #10

    // and  x13, x11, x7      0075F6B3   --> R-Type 
    if(DUT.PC === 32'h28 ) begin
        $display("PASSED : branch instruction 2 and PC is incremented");
    end 
    else begin
        $display("FAILED : branch instruction 2 and PC is incremented");
    end 
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hD & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h4) begin
            $display("PASSED : and instruction 2");
        end 
        else begin
            $display("FAILED : and instruction 2");
        end 
    end 

    #10
    // add  x14, x13, x11      00B68733   --> R-Type 

    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hE & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h10) begin
            $display("PASSED : add instruction 2");
        end 
        else begin
            $display("FAILED : add instruction 2");
        end 
    end 

    #10

    // sw   x14, 8(x12)  --> [9] = x14 = 16   00E62423  --> S-Type

    if(DUT.MemWrite) begin
        if(DUT.DataAdr === 32'h9 & DUT.WriteData === 32'h10) begin
            $display("PASSED : store instruction");
        end 
        else begin
            $display("FAILED : store instruction");
        end 
    end 

    #10


    // lw   x15, -2(x9)       ffe32503   --> I-Type
    
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'hf & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h10) begin
            $display("PASSED : load instruction");
        end 
        else begin
            $display("FAILED : load instruction");
        end 
    end 

    #10

    // jal  x16, L3       00C50463   --> B-Type
    // unconditional jump
    if(DUT.U0_processor.U0_control_unit.PCSrc && DUT.U0_processor.U0_control_unit.Jump) begin
        $display("PASSED : jump instruction");
    end
    else begin
        $display("FAILED : jump instruction");
    end  
    if(DUT.U0_processor.U1_Datapath.U0_RegFile.WE3) begin
        if(DUT.U0_processor.U1_Datapath.U0_RegFile.A3 === 32'h10 & DUT.U0_processor.U1_Datapath.U0_RegFile.WD3 === 32'h3C) begin
            $display("PASSED : jump instruction old PC + 4 is written in RegFile");
        end 
        else begin
            $display("FAILED : jump instruction old PC + 4 is written in RegFile");
        end 
    end

    #10

    if(DUT.PC === 32'h40 ) begin
        $display("PASSED : jump instruction and PC is incremented");
    end 
    else begin
        $display("FAILED : jump instruction and PC is incremented");
    end 
    
  
end


// GENERATE CLOCK
always #5 clk_tb = ~clk_tb ;

// DUT instantiation

RISCV_top DUT (
    .clk  (clk_tb) ,
    .rst  (rst_tb) 
);

endmodule