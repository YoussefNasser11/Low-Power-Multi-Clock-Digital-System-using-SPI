`timescale 1ns/1ps

module FCS(data_i,lfsr,clk,rstn);

output reg [0:15] lfsr;
input clk,rstn;
input data_i;

always @(posedge clk or negedge rstn)
begin
if (!rstn)
begin 
lfsr <= 16'h 0000;  //initial value of crc =0
end
else
begin
    lfsr[0]  <= lfsr[1];
    lfsr[1]  <= lfsr[2];
    lfsr[2]  <= lfsr[3];
    lfsr[3]  <= lfsr[4] ^ lfsr[0] ^ data_i;
    lfsr[4]  <= lfsr[5];
    lfsr[5]  <= lfsr[6];
    lfsr[6]  <= lfsr[7];
    lfsr[7]  <= lfsr[8];
    lfsr[8]  <= lfsr[9];
    lfsr[9]  <= lfsr[10];
    lfsr[10] <= lfsr[11] ^ lfsr[0] ^ data_i;
    lfsr[11] <= lfsr[12];
    lfsr[12] <= lfsr[13];
    lfsr[13] <= lfsr[14];
    lfsr[14] <= lfsr[15];
    lfsr[15] <= lfsr[0] ^ data_i;
end
    

end

endmodule 
