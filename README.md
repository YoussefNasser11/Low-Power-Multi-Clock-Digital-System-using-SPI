o Key Blocks
SPI Master: Within the project, I was responsible for developing a test bench that emulated the SPI Master. Works with SPI CLK 26MHz.
SPI Slave: SPI Slave block received data from the Master during write operations and stored it in the register file. It also transmitted data from the register file to the Master during read operations. Works with SPI CLK 26MHz.
Register File: I developed the Register File, which served as a storage unit for the data received from the SPI Slave during write operations. Additionally, it transmitted data to the CRC and Serializer components. Works with SPI CLK 26MHz.
CRC 16: I implemented the CRC block, performing logical operations to generate check bits to the payload. Works with Sys CLK 32MHz.
Serializer: It receives data bytes from the Register File and checks bytes from the CRC. It serialized the combined data and transmitted it to the Physical layer at a divided clock rate of either 1Mbps or 2Mbps, based on the selected mode. Works with Sys CLK 32MHz.
o Design Topologies
Frequency Divider: Implemented a frequency divider to divide the system clock from 32MHz to 1MHz or 2MHz.
Clock Gating: Utilized clock gating techniques for the whole system.
Synchronizers: Incorporated CDC and RDC synchronizers to ensure reliable data transfer between different domains.
o Design Flow
Design Architecture: Defined the system architecture and identified key components.
RTL Developed the RTL using Verilog.
Verification: Conducted linting, CDC, and RDC checks using Spyglass
Synthesis: Performed synthesis using Design Compiler to generate an optimized gate-level netlist.
GLS: Using VCS to validate the functionality and timing of the design.
LEC: Utilized Formality for formal verification to ensure the gate-level design. matched the RTL design.
DFT Two Scan chains, one for each domain using the Multiplexing method.
Test Max was used for ATPG.
o Scripting
Synthesis, Formality, DFT, and ATPG using TCL.
