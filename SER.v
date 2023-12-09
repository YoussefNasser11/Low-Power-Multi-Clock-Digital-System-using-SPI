`timescale 1ns/1ps
module SER
(


input [31:0] data_payload ,
input sys_clk,reset,load,
input [0:15] data_crc,
input mode,
output reg serial_done_tick,
output reg serial_out

);

reg [4:0] counter;
reg [6:0] counter_tick;
wire [71:0] data_in;
reg [71:0] data_reg;

reg Div_clk_d1;



assign data_in = {24'b0101_0101_0101_0101_0111_1010,data_payload,data_crc};


always@(posedge sys_clk or negedge reset)
begin

					if(reset == 0)
					begin
					Div_clk_d1 <= 0;
					counter <= 0;
					end 
					
					else if (mode == 0)
					begin
					if (counter == 31 )
						begin
					Div_clk_d1 <= 1'b1;
					counter <= 0;
						end
							else begin
							Div_clk_d1 <= 0 ;
		                 	counter <= counter +1;
							end
					end
				
					else if (mode == 1)
					begin
					
					if (counter == 15 )
						begin
					Div_clk_d1 <= 1'b1;
					counter <= 0;
						end
					else begin
							Div_clk_d1 <= 0 ;
		                 	counter <= counter +1;
					end
					end
					
			
	end



always@(posedge sys_clk or negedge reset)
begin

 if(reset == 0) begin
	      serial_out <=0;
		data_reg <=0;
		counter_tick <= 0;
		serial_done_tick <= 0;
 end
				
else if (load)
	data_reg <= data_in;
	else if (Div_clk_d1)
	begin
	
	data_reg <= data_reg<<1;
	serial_out <= data_reg[71];
	counter_tick <= counter_tick +1;
	
	end

else if (counter_tick == 75)
begin
serial_done_tick <= 1;
end
else 
  begin
    serial_done_tick <= 0;
  end
  
					end




endmodule