#!/usr/bin/tclsh

set projdir [ file normalize "../../[ file dirname [ info script ] ]" ] 

# Xillinx Project Variables
set projname TEA_VIVADO_PROJECT
set vivado_projdir [ file normalize [ file dirname "$projdir/$projname" ] ] 
set partnumber xc7a35tcpg236-1

# Design Variables
set incdirs [list $projdir]

# Create project
create_project -force $projname $projdir -part $partnumber
set_property board_part digilentinc.com:basys3:part0:1.1 [current_project]

# Add File
set_property include_dirs $incdirs [current_fileset]; #Include Directories

add_files -norecurse $filetop
add_files -norecurse -scan_for_includes "$projdir/verilog/tea.svh"
add_files -norecurse -scan_for_includes {"$projdir/verilog/tea.sv" "$projdir/verilog/tea_apb_wrapper.sv"}

#Setting top
set_property top tea_apb_wrapper [current_fileset]

#Compiler
update_compile_order -fileset sources_1