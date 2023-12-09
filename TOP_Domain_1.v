`timescale 1ns/1ps
//TOP_Domain_1 without Sync
module TOP_Domain_1
#(parameter WIDTH = 8)
(
input csn,
input resetn,
input spi_clock,

input MOSI,
input rf_tx_done,

output rf_tx_start 	,  
output  rf_tx_mode 	, 
output  rf_power_domain,

output o_miso_ena,

output    [31:0]		rf_tx_data ,


output write_flag,
output MISO

);

wire WrEn;
wire [7:0] Address;
wire [7:0] slave_to_reg;
wire [7:0] reg_to_slave;

spi_slave block1(

.i_csn(csn), 
.i_sck(spi_clock),
.i_sck_neg(spi_clock),	
.i_mosi(MOSI),
.o_miso(MISO),
	
.i_rf_din(reg_to_slave), //wire
.o_rf_wre(WrEn),//wire
.o_rf_addr(Address),//WIRE
.o_dout(slave_to_reg),//wire

.o_miso_ena(o_miso_ena),
.i_scan_mode(1'b0),	
.i_ioring_rst_n(1'b0),
.i_status(16'd0) 

);

register_file block2(

.clk(spi_clock),
.resetn(resetn),
.write_enable(WrEn),
.address(Address),
.wr_data(slave_to_reg),
.rd_data(reg_to_slave),
.rf_tx_start(rf_tx_start), 	  
.rf_tx_mode(rf_tx_mode),
.rf_power_domain(rf_power_domain),
.rf_tx_data(rf_tx_data),
.rf_tx_done(rf_tx_done),
.write_flag(write_flag) 

);

endmodule
