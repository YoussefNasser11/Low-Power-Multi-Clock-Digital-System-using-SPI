`timescale 1ns/1ps
//CRC with SER TOP
module TOP(

input crc_load_ext,

input clk,
input reset,	
input [31:0] payload,

input mode,
input enable,

output packet,
output serial_done_tick

);

wire crc_load;
wire [0:15] crc_lfsr;


CRC CRC_Insta(

.enable(enable),
.crc_data_in(payload),
.crc_load(crc_load_ext),


.clk(clk),
.rstn(reset),

.crc_serial_done_tick(crc_load),
.LFSR(crc_lfsr)

);

SER SER_Insta(
  
.data_payload(payload),  
.data_crc(crc_lfsr),
.sys_clk(clk),

.reset(reset),
.mode(mode),
.load(crc_load),



.serial_done_tick(serial_done_tick),
.serial_out(packet)

);

endmodule 
