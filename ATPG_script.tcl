##ATPG##
#tmax -tcl ATPG_script.tcl
##path
set RTL_PATH /home/svacddf202201yofattah/YoussefNasser/DFT_test_1/TetraMax
##read_Netlist files##
read_netlist $RTL_PATH/sys_dft_final.v
read_netlist $RTL_PATH/saed32nm_hvt.v
##build_model###
run_build_model TOP_SYSTEM_DFT
##DRC_Setup##
set_drc $RTL_PATH/System_Tetra_Max_final_isa.spf
run_drc
##Test##
add_faults -module TOP_SYSTEM_DFT
run_atpg -auto_compression basic_scan_only

report_faults -sum -uncoll
report_faults -sum -coll