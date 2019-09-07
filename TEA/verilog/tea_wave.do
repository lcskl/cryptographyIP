onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/o_data
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/o_ready
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/i_data
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/i_addr
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/i_we
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/i_clk
add wave -noupdate -expand -group DUT_INTERFACE -radix hexadecimal /tb/dut/i_rstn
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/current_state
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/next_state
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/count
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/count_en
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/k0
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/k1
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/k2
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/k3
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/v0
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/v1
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/sum_enc
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal /tb/dut/sum_dec
add wave -noupdate -group DUT_INTERNAL -radix hexadecimal -childformat {{{/tb/dut/mem_reg[0]} -radix hexadecimal} {{/tb/dut/mem_reg[1]} -radix hexadecimal} {{/tb/dut/mem_reg[2]} -radix hexadecimal} {{/tb/dut/mem_reg[3]} -radix hexadecimal} {{/tb/dut/mem_reg[4]} -radix hexadecimal}} -expand -subitemconfig {{/tb/dut/mem_reg[0]} {-height 16 -radix hexadecimal} {/tb/dut/mem_reg[1]} {-height 16 -radix hexadecimal} {/tb/dut/mem_reg[2]} {-height 16 -radix hexadecimal} {/tb/dut/mem_reg[3]} {-height 16 -radix hexadecimal} {/tb/dut/mem_reg[4]} {-height 16 -radix hexadecimal}} /tb/dut/mem_reg
add wave -noupdate -radix hexadecimal /tb/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1361 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {2224 ps}
