module SPI_RAM (MOSI, MISO, SS_n, clk, rst_n);
input MOSI, clk, rst_n, SS_n;
output MISO;
wire [9:0] rx_data;
wire [7:0] dout;
wire rx_valid, tx_valid;
wire MISO_reg; 
reg miso_ay;

parameter IDLE = 3'b000;
parameter WRITE = 3'b001;
parameter READ_ADD = 3'b010;
parameter READ_DATA = 3'b011;
parameter CHK_CMD = 3'b100;

(* fsm_encoding = "one_hot" *)
reg [2:0] cs, ns;


SPI DUT1 (MOSI, MISO_reg, SS_n, clk, rst_n, rx_data, rx_valid, dout, tx_valid);
RAM DUT2 (clk, rst_n, rx_data, rx_valid, dout, tx_valid);

always @(posedge clk or negedge rst_n) begin
  if (~rst_n) begin
    cs <= IDLE;
    end
    else begin
        cs <= ns;
    end
end

always @(SS_n, MOSI, cs) begin
    case (cs)
        IDLE:
            if (!SS_n) begin
                ns = CHK_CMD;
            end
            else begin
                ns = IDLE;
            end
        CHK_CMD:
            if (!SS_n && !DUT1.rx_data_reg[9]) begin
                ns = WRITE;
            end
            else if (!SS_n && DUT1.rx_data_reg[9] && DUT2.rd_valid) begin 
                ns = READ_DATA;
            end
            else if (!SS_n && DUT1.rx_data_reg[9]) begin
                ns = READ_ADD;
            end
            else if (SS_n) begin
                ns = IDLE;
            end
            else begin
                ns = CHK_CMD;
            end
        WRITE:
            if (!SS_n && !DUT1.rx_data_reg[9]) begin
                ns = WRITE;
            end
            else begin
                ns = IDLE;
            end
        READ_ADD:
            if (!SS_n && DUT1.rx_data_reg[9]) begin
                ns = READ_ADD;
            end
            else begin
                ns = IDLE;
            end
        READ_DATA:
            if (!SS_n && DUT1.rx_data_reg[9] && DUT2.rd_valid) begin
                ns = READ_DATA;
            end
            else begin
                ns = IDLE;
            end
        default: ns = IDLE;    
    endcase
end

always @(posedge clk) begin
  if (cs == READ_DATA) begin
    miso_ay <= MISO_reg;
  end
end
assign MISO = miso_ay;
endmodule
