module SPI (MOSI, MISO, SS_n, clk, rst_n, rx_data, rx_valid, tx_data, tx_valid); 
input MOSI, tx_valid, SS_n, clk, rst_n;
input [7:0] tx_data;
output reg MISO, rx_valid;
output reg [9:0] rx_data;
reg [9:0] rx_data_reg;
integer i,j;

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    MISO <= 0;
    rx_data <= 0;
    rx_valid <= 0;
    i <= 0;
    j <= 0;
  end
  else begin
    if (~SS_n) begin
        if (tx_valid) begin
            if (j<8) begin
                MISO <= tx_data [7-j];
                j <= j+1;
            end
            else begin
                j <= 0;
                MISO <= 0;
            end
        end         
       else begin
            if (i<10) begin  
              rx_data_reg[9-i] <= MOSI;
              i <= i+1;
            end
            else begin
                if (i == 10) begin
                    rx_data <= rx_data_reg;
                    i <= i+1;
                    rx_valid <= 1;
                end
                else begin
                    i <= 0;
                    rx_valid <= 0;
                    rx_data_reg <= 0;
                end
            end 
       end
  end
  else begin
    j <= 0;
    i <= 0;
  end
end 
end   
endmodule



