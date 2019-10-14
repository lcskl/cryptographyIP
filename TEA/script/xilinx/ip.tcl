#!/usr/bin/tclsh

#@TODO: Invetigate the following warning:
#           - WARNING: [IP_Flow 19-5101] Packaging a component with a SystemVerilog top file is not fully supported. Please refer to UG1118 'Creating and Packaging Custom IP'.

set rootdir [ file normalize "../../[ file dirname [ info script ] ]" ]
set projdir "$rootdir/VIVADO_PROJECT"

# Xillinx Project Variables
set projname TEA_VIVADO_PROJECT
set partnumber "xc7a35tcpg236-1"

# Design Variables
set incdirs [list "$rootdir/verilog"]

# Environment settings
if ![file exists $projdir]  {file mkdir $projdir}

# Create project
create_project -force $projname $projdir -part $partnumber

# Add File
set_property include_dirs $incdirs [current_fileset]; #Include Directories

add_files -norecurse -scan_for_includes $rootdir/verilog/tea.svh
add_files -norecurse -scan_for_includes $rootdir/verilog/tea.sv
add_files -norecurse -scan_for_includes $rootdir/verilog/tea_apb_wrapper.sv

#Setting top
set_property top tea_apb_wrapper [current_fileset]

#Compiler
update_compile_order -fileset sources_1

#Synthesis
launch_runs synth_1 -jobs 4

#Creating IP
ipx::package_project -import_files { $rootdir/verilog/tea.svh $rootdir/verilog/tea.sv $rootdir/verilog/tea_apb_wrapper.sv } -root_dir $projdir -vendor SoinMicroelectronic.org -library soin_ip -taxonomy /SoinIP -generated_files

#Creating Interface
set_property abstraction_type_vlnv {xilinx.com:interface:apb_rtl:1.0} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property bus_type_vlnv {xilinx.com:interface:apb:1.0} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property interface_mode {slave} [ipx::get_bus_interface APB_S [ipx::current_core]]
ipx::add_port_map {PREADY} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PREADY} [ipx::get_port_map PREADY [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PSEL} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PSEL} [ipx::get_port_map PSEL [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PENABLE} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PENABLE} [ipx::get_port_map PENABLE [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PRDATA} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PRDATA} [ipx::get_port_map PRDATA [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PADDR} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PADDR} [ipx::get_port_map PADDR [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PWRITE} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PWRITE} [ipx::get_port_map PWRITE [ipx::get_bus_interface APB_S [ipx::current_core]]]
ipx::add_port_map {PWDATA} [ipx::get_bus_interface APB_S [ipx::current_core]]
set_property physical_name {PWDATA} [ipx::get_port_map PWDATA [ipx::get_bus_interface APB_S [ipx::current_core]]]

#Clock Reset
ipx::infer_bus_interface PCLK xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface PRESETn xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]


#Creating Address Map
ipx::add_memory_map {APB_S} [ipx::current_core]
set_property slave_memory_map_ref {APB_S} [ipx::get_bus_interface APB_S [ipx::current_core]]
ipx::add_address_block {TEA_REG} [ipx::get_memory_map APB_S [ipx::current_core]]
set_property range {16} [ipx::get_address_blocks TEA_REG -of_objects [ipx::get_memory_maps APB_S -of_objects [ipx::current_core]]]


set_property core_revision 1 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  $projdir [current_project]
update_ip_catalog; #Is it necessary?

exit