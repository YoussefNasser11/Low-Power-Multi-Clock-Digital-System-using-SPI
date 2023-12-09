`timescale 1ns/1ps

module PISO(


input clk,
input reset,
input [31:0] data_in,
input piso_load,

input enable,


output reg piso_serial_done_tick,
output reg piso_serial_out


);


// PISO Block
reg [5:0] counter; //log base 2 (DW)
reg [31:0] data_reg;
reg piso_serialize;

always@(posedge clk or negedge reset)
begin 
	if(!reset)
 	begin 
	piso_serial_out<=0;
	data_reg<=0;
	counter <= 0;
	piso_serialize <= 0;
	end

	else begin 
	if (counter == 32'd33)
  	begin
 	piso_serialize <= 0;
	end

 	else if(piso_load && enable )
  	begin 
	data_reg <= data_in ;
	counter <= 0;
	piso_serialize <= 1'b1;
	end

	else if (piso_serialize)
 	begin
	data_reg <= data_reg<<1;
	piso_serial_out <= data_reg[31];
	counter <= counter + 1 ;
	end
end


end

always@(posedge clk or negedge reset)
begin
  	if(!reset)
 	begin 
	piso_serial_done_tick<=1'b0;
	end

	else if (counter == 32)
        begin
 	piso_serial_done_tick <= 1;
	end

	else
	begin
  	piso_serial_done_tick <= 1'b0;
	end
	
end

endmodule
