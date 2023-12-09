set path_lib /tools/PDK/install/SAED_PDK32nm/memory/lib_stdcell_hvt/db_ccs/
set RTL_path /home/svacddf202201yofattah/YoussefNasser/DFT_test_1
lappend search_path $path_lib

set MLIB "saed32hvt_ss0p7vn40c.db"

set target_library [list $MLIB]
set link_library [list * $MLIB]

set file_format verilog


read_file -format $file_format $RTL_path/TOP_SYSTEM_DFT.v
read_file -format $file_format $RTL_path/TOP_Domain_1_DFT.v
read_file -format $file_format $RTL_path/register_file.v
read_file -format $file_format $RTL_path/spi_slave.v
read_file -format $file_format $RTL_path/TOP_DFT.v
read_file -format $file_format $RTL_path/SER4.v
read_file -format $file_format $RTL_path/CRC.v
read_file -format $file_format $RTL_path/PISO.v
read_file -format $file_format $RTL_path/FCS.v
read_file -format $file_format $RTL_path/BIT_SYNC.v
read_file -format $file_format $RTL_path/Reset_Sync1.v
read_file -format $file_format $RTL_path/Mux2x1.v
read_file -format $file_format $RTL_path/Mux_ve_2x1.v



current_design TOP_SYSTEM_DFT
link

check_design

set_units -time ns
set_units -capcitance ff

set_wire_load_model -name "16000" -library saed32hvt_ss0p7vn40c

set_driving_cell -lib_cell IBUFFX4_HVT -library saed32hvt_ss0p7vn40c -pin Y [get_ports MOSI]
set_driving_cell -lib_cell IBUFFX4_HVT -library saed32hvt_ss0p7vn40c -pin Y [get_ports csn]

create_clock -name spi_clock -period 38.46 -waveform {0 19.23} [get_ports spi_clock]
create_clock -name spi_clock -period 31.25 -waveform {0 15.625} [get_ports sys_clk]

set_clock_uncertainty -setup 0.05 [get_clocks spi_clock]
set_clock_uncertainty -setup 0.05 [get_clocks sys_clk]

set_clock_transistion 0.5 -fall max {spi_clock sys_clk}
set_clock_transistion 0.5 -rise max {spi_clock sys_clk}

set_clock_groups -asynchronous -group [get_clocks {spi_clock}] \
-group [get_clocks {sys_clk}]

set_multicycle_path -setup 3 -from spi_clock -to sys_clk
set_multicycle_path -hold 2 -from spi_clock -to sys_clk

create_clock -name scan_spi_clock -period 100000 -waveform {0 50000} [get_ports scan_spi_clock]
create_clock -name scan_sys_clock -period 84000 -waveform {0 42000} [get_ports scan_sys_clock]

set_clock_uncertainty -setup 0.05 [get_clocks scan_spi_clock]
set_clock_uncertainty -setup 0.05 [get_clocks scan_sys_clock]

set_input_delay -clock scan_spi_clock -max 250 [get_ports Scan_mode]


set_input_delay -clock spi_clock -max 7.69 [get_ports MOSI]
set_input_delay -clock spi_clock -max 7.69 [get_ports csn]

set_output_delay -clock spi_clock -max 7.69 [get_ports o_miso_ena]
set_output_delay -clock spi_clock -max 7.69 [get_ports MISO]
set_output_delay -clock sys_clk -max 6.25 [get_ports packet]

group_path -name INREG -from [all_inputs]
group_path -name REGOUT -to [all_outputs]
group_path -name INOUT -from [all_inputs] -to [all_outputs]

set_max_fanout 32 [all_inputs]
set_max_capcitance 0.15 [all_outputs]
set_input_transition 13 [all_inputs]

set_load -max 0.15 [get_ports MISO]
set_load -max 0.15 [get_ports packet]
set_load -max 0.15 [get_ports o_miso_ena]

set_max_area 0

compile_enable_register_merging false	

set_case_analysis 1 [get_ports Scan_mode]

compile_ultra -noautoungroup -gate_clock


set_svf "My_System.svf"

set path2 /home/svacddf202201yofattah/YoussefNasser/DFT_test_1/reports

write_file -format verilog -hierarchy -output $path2/GLS/TOP_SYSTEM_Netlist.v
write_file -format ddc -hierarchy -output $path2/TOP_SYSTEM_ddc.ddc
write_sdc -nosplit $path2/TOP_SYSTEM_sdf.sdf
write_sdc -nosplit $path2/TOP_SYSTEM_sdgc.sdc
write_sdc -nosplit $path2/TOP_SYSTEM_sdgc.sdgc

report_area -hierarchy > $path2/area_final.rpt
report_power -hierarchy > $path2/power.rpt
report_timing -max_paths 100 -delay_type min > $path2/hold_final.rpt
report_timing -max_paths 99 -delay_type max > $path2/setup.rpt
report_timing > $path2/Timing_report_final.rpt
report_clock -attributes > $path2/clocks_final.rpt
report_constraint -all_violators > $path2/constraint_final.rpt

