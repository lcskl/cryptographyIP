onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PCLK
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PRESETn
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PRDATA
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PREADY
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PWDATA
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PADDR
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PWRITE
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PSEL
add wave -noupdate -expand -group TB -radix hexadecimal /tea_apb_wrapper_tb/PENABLE
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/current_state
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/next_state
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/count
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/count_en
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/k0
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/k1
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/k2
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/k3
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/v0
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/v1
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/sum_enc
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/sum_dec
add wave -noupdate -expand -group {INTERNAL REGS} -radix hexadecimal -childformat {{{/tea_apb_wrapper_tb/dut/TEA/mem_reg[0]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[1]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[2]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[3]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[4]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[5]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[6]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[7]} -radix hexadecimal} {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[8]} -radix hexadecimal}} -subitemconfig {{/tea_apb_wrapper_tb/dut/TEA/mem_reg[0]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[1]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[2]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[3]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[4]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[5]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[6]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[7]} {-height 16 -radix hexadecimal} {/tea_apb_wrapper_tb/dut/TEA/mem_reg[8]} {-height 16 -radix hexadecimal}} /tea_apb_wrapper_tb/dut/TEA/mem_reg
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/i_clk
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/i_rstn
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/o_data
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/o_ready
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/i_data
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/i_addr
add wave -noupdate -expand -group {INTERNAL SIGS} -radix hexadecimal /tea_apb_wrapper_tb/dut/TEA/i_we
add wave -noupdate -radix hexadecimal /tea_apb_wrapper_tb/data_out_pt1
add wave -noupdate -radix hexadecimal /tea_apb_wrapper_tb/data_out_pt2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 149
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2080 ps} {2175 ps}
