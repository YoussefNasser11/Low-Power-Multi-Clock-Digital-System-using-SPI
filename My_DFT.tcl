set top_module TOP_SYSTEM_DFT

set path_lib /tools/PDK/install/SAED_PDK32nm/memory/lib_stdcell_hvt/db_ccs/
set RTL_path /home/svacddf202201yofattah/YoussefNasser/DFT_test_1

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

source $RTL_path/My_Syn.tcl

compile -scan

set_scan_configuration -clock_mixing no_mix -style multiplexed_flip_flop -replace ture \
-add_lockup true -reuse_mv_cells true -count_per_domain 1

set compile_fix_multiple_port_nets "true"

set_clock_gating_style -control_point before -control_signal scan_enable

set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0

set_dft_signal -view existing_dft -type ScanMasterClock -timing {30 60} -port [get_ports scan_sys_clock]
set_dft_signal -view existing_dft -type Reset -active_state 0 -port [get_ports Scan_set_reset_2]
set_dft_signal -view existing_dft -type ScanMasterClock -timing {30 60} -port [get_ports scan_spi_clock]
set_dft_signal -view existing_dft -type Reset -active_state 0 -port [get_ports i_ioring_rst_n]
set_dft_signal -view existing_dft -type constant -active_state 1 -port [get_ports Scan_mode]

set_dft_signal -view spec -type TestMode -active_state 1 -port [get_ports Scan_mode]
set_dft_signal -view spec -type Scan_Enable -active_state 1 -port [get_ports scan_shift_enable]
set_dft_signal -view spec -type Scan_DataIn   -port [get_ports scan_input_1]
set_dft_signal -view spec -type Scan_DataOut  -port [get_ports scan_output_1]
set_dft_signal -view spec -type Scan_DataIn   -port [get_ports scan_input_2]
set_dft_signal -view spec -type Scan_DataOut  -port [get_ports scan_output_2]
set_dft_signal -view spec -type Scan_Enable -usage clock_gating -port [get_ports scan_shift_cg]

gui_start

create_test_protocol

dft_drc -verbose

preview_dft -show scan_summary

insert_dft

compile  -scan -incremental

dft_drc -verbose -coverage_estimate

write_test_protocol -output System_Tetra_Max_final_isa.spf
write_test_protocol -output System_Tetra_Max_final_isa.stil

write_file -format verilog -hierarchy -output sys_dft_final.v

