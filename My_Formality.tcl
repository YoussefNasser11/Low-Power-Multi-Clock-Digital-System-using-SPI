#formality -f My_Formality.tcl

##formality setup##

set synopsys_auto_setup true

##formality Guidence ##

set_svf -append {/home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/default.svf}


## formality REF ##
read_verilog -container r -libname WORK -05 { /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/TOP_SYSTEM.v  /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/TOP_Domain_1.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/register_file.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/spi_slave.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/TOP.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/SER4.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/CRC.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/PISO.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/FCS.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/BIT_SYNC.v /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/Reset_Sync.v }

read_db -container { /tools/PDK/install/SAED_PDK32nm/memory/lib_stdcell_hvt/db_ccs/saed32hvt_ss0p7vn40c.db }

set_top r:/WORK/TOP_SYSTEM

## formality Imp ##

read_verilog -container i -libname WORK	-05 { /home/svacddf202201yofattah/YoussefNasser/RTL_Data_quasi/reports/GLS/TOP_SYSTEM_Netlist.v }

read_db  { /tools/PDK/install/SAED_PDK32nm/memory/lib_stdcell_hvt/db_ccs/saed32hvt_ss0p7vn40c.db }

set_top i:/WORK/TOP_SYSTEM

##formality matching points##
matching
##formality verifying##
verify