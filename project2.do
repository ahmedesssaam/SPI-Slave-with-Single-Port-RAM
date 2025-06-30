vlib work
vlog SPI.v S-RAM.v SPI-RAM.v tb_SPI_RAM.v
vsim -voptargs=+acc work.tb_SPI_RAM
add wave *
run -all
#quit -sim