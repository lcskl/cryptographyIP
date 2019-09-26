
TOCLEAR={ vivado* , VIVADO_PROJECT , script/xilinx/vivado*, script/xilinx/.Xil , .Xil/ }

help:
	@echo "make help  -  Display the help command list"
	@echo "make ip    -  build the Vivado TEA IP packaging"

ip:
	cd script/xilinx/ && vivado -source -mode tcl -source ip.tcl

clean:
	rm -rf $(TOCLEAR)