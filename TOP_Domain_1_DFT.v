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

//DFT//

input scan_sys_clock,
input i_ioring_rst_n,
input Scan_mode,
input scan_shift_enable,
input scan_shift_cg,
input scan_spi_clock,
input scan_input_1,
output scan_output_1,

//DFT//

output write_flag,
output MISO

);
wire ve_clock;
wire domain_1_clock;
wire CSN_reset;
wire domain_1_reset_2;
wire WrEn;
wire [7:0] Address;
wire [7:0] slave_to_reg;
wire [7:0] reg_to_slave;
wire Reg_reset ;

spi_slave block1(

.i_csn(CSN_reset), 
.i_sck(domain_1_clock),
.i_sck_neg(ve_clock),	
.i_mosi(MOSI),
.o_miso(MISO),
	
.i_rf_din(reg_to_slave), //wire
.o_rf_wre(WrEn),//wire
.o_rf_addr(Address),//WIRE
.o_dout(slave_to_reg),//wire

.o_miso_ena(o_miso_ena),
.i_scan_mode(Scan_mode),	
.i_ioring_rst_n(i_ioring_rst_n),
.i_status(16'd0) 

);

register_file block2(

.clk(domain_1_clock),
.resetn(Reg_reset),
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


Mux2X1 Domain_1_csn(
.Function_mode(spi_clock),
.Test_mode(scan_spi_clock),
.sel(Scan_mode),
.Mux_Out(domain_1_clock)
);

Mux2X1_ve_2x1 Domain_ve_spi_clock(
.Function_mode(spi_clock),
.Test_mode(scan_spi_clock),
.sel(Scan_mode),
.Mux_Out(ve_clock)
);


Mux2X1 Domain_1_csn(
.Function_mode(csn),
.Test_mode(i_ioring_rst_n),
.sel(Scan_mode),
.Mux_Out(CSN_reset)
);

Mux2X1 Domain_1_csn(
.Function_mode(reset),
.Test_mode(i_ioring_rst_n),
.sel(Scan_mode),
.Mux_Out(Reg_reset)
);



endmodule