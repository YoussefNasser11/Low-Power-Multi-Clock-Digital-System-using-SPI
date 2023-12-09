
`timescale 1ns/1ps

module BIT_SYNC #(parameter NUM_STAGES = 2, BUS_WIDTH = 1)
(
    input   wire [BUS_WIDTH-1:0]    ASYNCH                          								,
    input   wire                    RST                             								,
    input   wire                    CLK                             								,
	input   wire Scan_mode , Scan_CLK , Scan_Reg_reset,
    output  reg  [BUS_WIDTH-1:0]    SYNC
);

wire Reg_reset;
wire Sync_clk;

Mux2X1 laaac3(
.Function_mode(RST),
.Test_mode(Scan_Reg_reset),
.sel(Scan_mode),
.Mux_Out(Reg_reset)
);

Mux2X1 laaac4(
.Function_mode(CLK),
.Test_mode(Scan_CLK),
.sel(Scan_mode),
.Mux_Out(Sync_clk)
);




    reg          [NUM_STAGES-1:0]   register    [BUS_WIDTH-1:0]   									;
	integer 						counter															;

/****************************/
/****************************/

	always @(posedge Sync_clk or negedge Reg_reset) 
		begin

			if(!Reg_reset)

				for (counter = 0 ; counter < BUS_WIDTH ; counter = counter + 1 ) 
					begin

						register[counter] <= 'b0													;
						SYNC[counter]	  <= 'b0													;
					
					end                            	                                                                                      
				
			else
				begin

					for (counter = 0 ; counter < BUS_WIDTH ; counter = counter + 1 ) 

						{SYNC[counter],register[counter]} <= {register[counter],ASYNCH[counter]}	;
							
				end	
		end

endmodule
