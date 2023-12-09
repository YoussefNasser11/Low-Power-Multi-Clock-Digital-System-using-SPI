`timescale 1ns/1ps

module TOP_SYSTEM
#(parameter WIDTH = 8 )
(
input csn,
input sys_reset,
input spi_clock,
input sys_clk,

input MOSI,



//output clk_mode,
output o_miso_ena,
output packet,
output MISO

);


wire write_flag;
wire [31:0] Payload_data;
wire start_enable;
wire mode_to_mode;

wire domain2_enable;
wire domain2_mode;
wire domain2_done_async;
wire domain1_done_sync;

wire rst_d1;
wire rst_d2;


TOP_Domain_1 TOP_Domain_1_Insta (

.csn(csn),
.resetn(rst_d1),
.spi_clock(spi_clock),
.MOSI(MOSI),
.o_miso_ena(o_miso_ena),
.rf_tx_start(start_enable),	
.rf_tx_mode(mode_to_mode),
.rf_power_domain(),
.rf_tx_data(Payload_data),
.rf_tx_done(domain1_done_sync),

.write_flag(write_flag),
.MISO(MISO)
);




TOP TOP_CRC_SER_Insta(

.crc_load_ext(write_flag),

.clk(sys_clk),
.reset(rst_d2),
.payload(Payload_data),
.mode(domain2_mode),

.enable(domain2_enable),

.packet(packet),
.serial_done_tick(domain2_done_async)

);


////////////////////////////////////////////////



//output of start bit in domain 1 to enable in domain 2
BIT_SYNC BIT_SYNC_start(
.ASYNCH(start_enable),         				
.RST(rst_d2),                       			
.CLK(sys_clk),                       		

.SYNC(domain2_enable)
);

//output mode of domain 1 to mode of domain 2
BIT_SYNC BIT_SYNC_mode(
.ASYNCH(mode_to_mode),                  	
.RST(rst_d2),                       					
.CLK(sys_clk),                       								
.SYNC(domain2_mode)
);



//output done tick of domain 2 to  domain 1
BIT_SYNC BIT_SYNC_done_tick(
.ASYNCH(domain2_done_async),                        
.RST(rst_d1),                       	
.CLK(spi_clock),                       						
.SYNC(domain1_done_sync)
);


//Reset domain 1


Reset_Sync Rst_D1
(
.RST(sys_reset),                        
.CLK(spi_clock),                              
.Sync_RST(rst_d1)    
);


//Reset domain 2
Reset_Sync Rst_D2
(
.RST(sys_reset),                        
.CLK(sys_clk),                              
.Sync_RST(rst_d2)    
);





endmodule
