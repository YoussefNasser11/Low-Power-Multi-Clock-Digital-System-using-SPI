`timescale 1ns/1ps

module CRC
#(parameter DW = 32 )
(

input [31:0] crc_data_in,
input crc_load,

input clk,
input rstn,

input enable,

output crc_serial_done_tick,
output [0:15] LFSR

);


wire PISO_to_CRC;


PISO U0(

.clk(clk),
.reset(rstn),
.data_in(crc_data_in),
.piso_load(crc_load),

.enable(enable),
.piso_serial_done_tick(crc_serial_done_tick),
.piso_serial_out(PISO_to_CRC)

);


FCS U1(

.lfsr(LFSR),
.clk(clk),
.rstn(rstn),
.data_i(PISO_to_CRC)

);



endmodule
