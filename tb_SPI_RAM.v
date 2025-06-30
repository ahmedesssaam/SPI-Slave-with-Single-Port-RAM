module tb_SPI_RAM ();
reg MOSI, clk, rst_n, SS_n;
wire MISO;
SPI_RAM DUT1 (MOSI, MISO, SS_n, clk, rst_n);

initial begin

    clk=0;
    forever begin
        #1 clk=~clk;
    end
end

initial begin 
    $readmemh ("mem.dat", DUT1.DUT2.mem);

    rst_n = 0;
    SS_n = 0;
    @(negedge clk);

    rst_n = 1;

    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    repeat(3) @(negedge clk);
    
    SS_n = 1;
    @(negedge clk);
    
    SS_n = 0;
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 1;
    repeat(3) @(negedge clk);
    SS_n = 1;
    @(negedge clk);

    

    SS_n = 0;

    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    repeat(3) @(negedge clk);
    SS_n = 1;
    @(negedge clk);

    

    SS_n = 0;
    MOSI = 1;
    @(negedge clk);
    MOSI = 1;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 0;
    @(negedge clk);
    MOSI = 1;
    repeat(13) @(negedge clk);
    SS_n = 1;
    @(negedge clk);



    $stop;

end
endmodule











