module RAM (clk, rst_n, din, rx_valid, dout, tx_valid);

parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;


input clk, rst_n, rx_valid;
input [ADDR_SIZE+1:0] din;
output reg tx_valid;
output reg [ADDR_SIZE-1:0] dout;

reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0] hold_write;
reg [ADDR_SIZE-1:0] hold_read;
reg wr_valid, rd_valid;


always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
     tx_valid <= 0;
     dout <=0;
     end 

  else begin
    if (rx_valid) begin
    case (din[9:8])
       2'b00: begin
       hold_write <= din[7:0];
       wr_valid <= 1; end

       2'b01: begin
        if (wr_valid) begin
            mem [hold_write] <= din[7:0];
            wr_valid <= 0;end
        end

       2'b10: begin
       hold_read <= din[7:0];
       rd_valid <= 1; end

       2'b11: begin
        if (rd_valid) begin
            dout <= mem [hold_read];  
            tx_valid <= 1;
            rd_valid <=0; end
        end
    endcase    
   end
end
end


endmodule