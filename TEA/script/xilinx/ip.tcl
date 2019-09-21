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
#add_files -norecurse -scan_for_includes $rootdir/verilog/tea_xilinx_apb_wrapper.sv

#Setting top
set_property top tea_apb_wrapper [current_fileset]

#Compiler
update_compile_order -fileset sources_1

#Creating IP
ipx::package_project -import_files { $rootdir/verilog/tea.svh $rootdir/verilog/tea.sv $rootdir/verilog/tea_apb_wrapper.sv } -root_dir $projdir -vendor SoinMicroelectronic.org -library soin_ip -taxonomy /SoinIP -generated_files
set_property core_revision 2 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]
set_property  ip_repo_paths  $projdir [current_project]
update_ip_catalog; #Is it necessary?

exit