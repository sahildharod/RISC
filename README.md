## IITB-RISC

This project was a part of the course EE309 : Microprocessors in which we built a 6 staged pipelined RISC processosr using VHDL in a team of 4. The stages are instruction fetch, decode, register read, execute,
memory access and write back and it supports a total of 26 instructions. 

To improve CPI (cycles per instruction), we resolved data dependencies by implementing a forwarding unit as well as a stalling unit. In addition to this we also implemented a branch predictor to handle control flow instructions and hence further optimize the pipeline. Finally, we deployed it on an FPGA board for functional testing and timing analysis
