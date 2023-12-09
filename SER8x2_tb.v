`timescale 1ns/1ps

module SER8x2_tb;

  // Parameters
  localparam  W = 8;

  parameter T_TxByteClk = 2.666; // TxByteClk = TxDDRClk/4 -->  1500 MHz / 4 = 375 MHz  1000/375 ==> 2.666
  parameter T_TxDDRClk  = 0.666; // TxDDRClk 1500 MHz 1000/1500 ==> 0.666
  
  //Ports
  reg  TxByteClk;
  reg  TxDDRClk;
  reg  Tx_RST;
  reg  [W-1:0] TxByteHS;
  wire  Serial_B1;
  wire  Serial_B2;

  SER8x2 # (
    .W(W)
  )
  SER8x2_inst (
    .TxByteClk(TxByteClk),
    .TxDDRClk(TxDDRClk),
    .Tx_RST(Tx_RST),
    .TxByteHS(TxByteHS),
    .Serial_B1(Serial_B1),
    .Serial_B2(Serial_B2)
  );

  initial begin
    Tx_RST <= 1'b0; #T_TxByteClk; Tx_RST <= 1'b1;
    end

  initial begin
    TxByteClk =1'b0;
    forever #(T_TxByteClk/2) TxByteClk = ~TxByteClk;
   end

   initial begin
    TxDDRClk =1'b0;
    forever #(T_TxDDRClk/2) TxDDRClk = ~TxDDRClk;
   end

   initial begin
    TxByteHS <= 8'hAB;
    end

endmodule