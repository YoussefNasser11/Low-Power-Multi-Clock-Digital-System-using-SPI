`timescale 1ns/1ps


module Whole_Moudle_TestBench1
#(parameter WIDTH = 8 )
 ();

reg csn_tb;
reg sys_reset_tb;
reg spi_clock_tb; // 26 MHz of the first Domain	
reg sys_clk_tb; // 32 MHz Of the Second Domain 
//reg sck_neg_clock_tb;
reg mosi_tb;
	

//wire        clk_mode_tb;

wire        packet_tb;
wire MISO_tb;





parameter T_SPI = 38.462; // SPI CLK 26 MHz 1000/26
parameter T_Sys = 31.25; // Sys CLK 32 MHz 1000/32

//TOP BLOCK module
TOP_SYSTEM Slave_Reg_Sync(

.csn(csn_tb),
.spi_clock(spi_clock_tb),
//.sck_neg_clock(sck_neg_clock_tb),
.MOSI(mosi_tb),
.sys_reset(sys_reset_tb),
.sys_clk(sys_clk_tb),



//.clk_mode(clk_mode_tb),
.packet(packet_tb),
.MISO(MISO_tb)
);
initial begin
//Intializtion
csn_tb=1;
spi_clock_tb=0;
//sck_neg_clock_tb=0;
sys_clk_tb=0;
mosi_tb=0;

sys_reset_tb = 1'b0;
#(T_Sys/2);
sys_reset_tb = 1'b1;

csn_tb=0;
mosi_tb=0;


fork

begin // MOSI data from SPI Master which is our Test Bench 
#(T_SPI/2);

	//Command = 8'b0000_0010;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;


//Address=8'h00;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;

	//Data = 8'hAA;
	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;

		//Data = 8'hAB;
	
	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;
	//Data = 8'hAC;
	
	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;

	//Data = 8'hAD;
	
	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;
	 
	 // start [4] 
	 
	 
	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;
	 
	 //mode[5]
	 
	  mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;
	 
	 // power [6]
	 
	  mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
	
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
	 #T_SPI;
	 
	 
end
///////////////////////////////////////
begin // SPI_CLOCK Generator 

csn_tb = 0;
spi_clock_tb=1'b0;
//sck_neg_clock_tb=1'b0;

#T_SPI;


repeat(142)
 begin 
spi_clock_tb=1'b1;
//sck_neg_clock_tb=1'b1;
#(T_SPI*0.5);
spi_clock_tb=1'b0;
//sck_neg_clock_tb=1'b0;

#(T_SPI*0.5);
end

csn_tb = 1;
spi_clock_tb=1'b0;
//sck_neg_clock_tb=1'b0;


end

begin // System_Clock Generator 


sys_clk_tb=1'b0;


//#T_Sys;


repeat(3000)
 begin 
sys_clk_tb=1'b1;

#(T_Sys*0.5);
sys_clk_tb=1'b0;


#(T_SPI*0.5);
end


//sys_clk_tb=1'b0;


end
/*
	//Command = 8'b0000_0011;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;


//Address=8'h07;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
	
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;
*/

join
/*
csn_tb = 1'b1;
#(10*T_SPI);

csn_tb = 1'b0;
#(30*T_SPI);

csn_tb = 1'b1;
#(10*T_SPI);
*/

fork

begin 
#(T_SPI/2);

	//Command = 8'b0000_0011;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;


//Address=8'h07;

	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 0;
   	 #T_SPI;

   	 mosi_tb = 0;
   	 #T_SPI;
   	 mosi_tb = 1;
   	 #T_SPI;
	
   	 mosi_tb = 1;
   	 #T_SPI;
   	 mosi_tb = 1;
	 #T_SPI;

/*
csn_tb = 1;
spi_clock_tb=1'b0;
sck_neg_clock_tb=1'b0;
*/
end

begin // SPI_CLOCK Generator 

csn_tb = 0;
spi_clock_tb=1'b1;
//sck_neg_clock_tb=1'b1;

//#T_SPI;



repeat(401)
 begin 
csn_tb = 0;
spi_clock_tb=1'b1;
//sck_neg_clock_tb=1'b1;
#(T_SPI*0.5);
spi_clock_tb=1'b0;
//sck_neg_clock_tb=1'b0;

#(T_SPI*0.5);
end

csn_tb = 1;
spi_clock_tb=1'b0;
//sck_neg_clock_tb=1'b0;


end



join
$stop;

end


endmodule
