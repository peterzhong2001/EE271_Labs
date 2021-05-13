onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LFSR_testbench/CLOCK_50
add wave -noupdate /LFSR_testbench/reset
add wave -noupdate -radix hexadecimal -childformat {{{/LFSR_testbench/out[9]} -radix hexadecimal} {{/LFSR_testbench/out[8]} -radix hexadecimal} {{/LFSR_testbench/out[7]} -radix hexadecimal} {{/LFSR_testbench/out[6]} -radix hexadecimal} {{/LFSR_testbench/out[5]} -radix hexadecimal} {{/LFSR_testbench/out[4]} -radix hexadecimal} {{/LFSR_testbench/out[3]} -radix hexadecimal} {{/LFSR_testbench/out[2]} -radix hexadecimal} {{/LFSR_testbench/out[1]} -radix hexadecimal} {{/LFSR_testbench/out[0]} -radix hexadecimal}} -expand -subitemconfig {{/LFSR_testbench/out[9]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[8]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[7]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[6]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[5]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[4]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[3]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[2]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[1]} {-height 15 -radix hexadecimal} {/LFSR_testbench/out[0]} {-height 15 -radix hexadecimal}} /LFSR_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2649 ps} 0}
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
WaveRestoreZoom {0 ps} {3623 ps}
