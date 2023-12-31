module Reset_Sync #(parameter NUM_STAGES = 2)
(
    input   wire                    RST                                 ,
    input   wire                    CLK                                 ,

    output  reg                     Sync_RST    
);

/********************************************************************************/
/***************************Internal Signals*************************************/

    reg          [NUM_STAGES-1:0]   register                            ;

/********************************************************************************/
/********************************************************************************/

    always @(posedge CLK or negedge RST) 
        begin

            if(!RST)
                begin

                    register <= 'b0                                     ;
                    Sync_RST <= 'b0                                     ; 
                
                end
            else
            
                {Sync_RST,register} <= {register[NUM_STAGES-1:0],1'b1}  ;

        end

endmodule
