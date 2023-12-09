module cache_memory (input wire [9:0] memory_address,
input wire [31:0] data_in,
input wire clk , rst, read_en , write_en,
output reg [31:0] data_out,
output wire valid_to_control,
output wire [2:0] tag);

wire [4:0] line;
wire [1:0] offset;
reg signed [131:0] cache [31:0];  // 131 = 127 + 1 valid + 3 tag bits
integer i,j;
reg word;
reg [1:0] count;

parameter FIRST  = 2'b00;
parameter SECOND = 2'b01;
parameter THIRD  = 2'b10;
parameter FOURTH = 2'b11;

assign line   = memory_address [6:2];
assign tag    = memory_address [9:7];
assign offset = memory_address [1:0];

reg valid [31:0];
assign valid_to_control = valid [line];

// 4 clock cycle for valid block
always @(posedge clk or posedge rst) begin
if (rst) begin
count <= 1'b0;

for (j=0; j<32 ; j=j+1) valid[j] = 1'b0;
end
else if (write_en) begin
if (count == 4) begin
valid [line] <= 1; count <= 2'b00;
end
else
	count <= count + 1'b1;
end
end

always @(posedge clk or posedge rst) begin
if (rst) begin 
for (i=0; i<32 ; i=i+1) cache[i] = 132'b0; 
end
else if (write_en) begin
case (offset)
FIRST  : cache [line][31:0]  <= data_in;
SECOND : cache [line][63:32] <= data_in;
THIRD  : cache [line][95:64] <= data_in;
FOURTH : cache [line][127:96]<= data_in;
endcase
end
else if (read_en) begin
case (offset)
FIRST  : data_out <= cache [line][31:0]  ;
SECOND : data_out <= cache [line][63:32] ;
THIRD  : data_out <= cache [line][95:64] ;
FOURTH : data_out <= cache [line][127:96];
endcase
end 
end


endmodule