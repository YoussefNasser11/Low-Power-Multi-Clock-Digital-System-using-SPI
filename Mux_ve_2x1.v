`timescale 1ns/1ps

module mux2X1_ve_2x1  (

 input   wire                  Function_mode,
  input   wire                  Test_mode,
   input   wire                  sel,
    output  reg                  Mux_Out 
	
	 );
	 
	 always @(*)
	 begin
	    if (sel)
		   begin     Mux_Out = !Test_mode; 
		      end
			       else
				          begin          Mux_Out = Function_mode;
						         endend
								  endmodule