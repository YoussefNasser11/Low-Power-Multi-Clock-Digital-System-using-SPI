`timescale 1ns/1ps
//CRC with SER TOP
module TOP_DFT(

input crc_load_ext,

input clk,
input reset,	
input [31:0] payload,

input mode,
input enable,

//DFT//

input Scan_set_reset_2,
input Scan_mode,
input scan_shift_enable,
input scan_shift_cg,
input scan_sys_clock,
input scan_input_2,
output scan_output_2,

//DFT//
output packet,
output serial_done_tick

);
wire domain_2_reset;
wire domain_2_clock;
wire crc_load;
wire [0:15] crc_lfsr;


CRC CRC_Insta(

.enable(enable),
.crc_data_in(payload),
.crc_load(crc_load_ext),


.clk(domain_2_clock),
.rstn(domain_2_reset),

.crc_serial_done_tick(crc_load),
.LFSR(crc_lfsr)

);

SER SER_Insta(
  
.data_payload(payload),  
.data_crc(crc_lfsr),
.sys_clk(domain_2_clock),

.reset(domain_2_reset),
.mode(mode),
.load(crc_load),



.serial_done_tick(serial_done_tick),
.serial_out(packet)

);


Mux2X1 Domain_1_system_clock(
.Function_mode(clk),
.Test_mode(scan_sys_clock),
.sel(Scan_mode),
.Mux_Out(domain_2_clock)
);

Mux2X1 Domain_2_reset_sync(
.Function_mode(reset),
.Test_mode(Scan_set_reset_2),
.sel(Scan_mode),
.Mux_Out(domain_2_reset)
);





endmodule 
