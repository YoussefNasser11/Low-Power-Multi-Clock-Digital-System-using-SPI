`timescale 1ns/1ps
module Reset_Sync #(parameter NUM_STAGES = 2)
(
    input   wire                    RST , Scan_Reg_reset ,
    input   wire                    CLK ,Scan_mode ,Scan_CLK

    output  reg                     Sync_RST    
);

/********************************************************************************/
/***************************Internal Signals*************************************/
	wire Reg_reset;
	wire Sync_clk;
    reg          [NUM_STAGES-1:0]   register                            ;

/********************************************************************************/
/********************************************************************************/

Mux2X1 laaac1(
.Function_mode(RST),
.Test_mode(Scan_Reg_reset),
.sel(Scan_mode),
.Mux_Out(Reg_reset)
);

Mux2X1 laaac2(
.Function_mode(CLK),
.Test_mode(Scan_CLK),
.sel(Scan_mode),
.Mux_Out(Sync_clk)
);




    always @(posedge Sync_clk or negedge Reg_reset) 
        begin

            if(!Reg_reset)
                begin

                    register <= 'b0                                     ;
                    Sync_RST <= 'b0                                     ; 
                
                end
            else
            
                {Sync_RST,register} <= {register[NUM_STAGES-1:0],1'b1}  ;

        end

endmodule
